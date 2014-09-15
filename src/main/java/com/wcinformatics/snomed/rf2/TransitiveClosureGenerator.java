/*
// Copyright 2014 West Coast Informatics, LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
*/
package com.wcinformatics.snomed.rf2;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.PrintWriter;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Builder for a transitive closure table from SNOMED CT
 * RF2 Snapshot inferred relationships file.
 *
 * @author bcarlsen@westcoastinformatics.com
 */
public class TransitiveClosureGenerator {

  /** The relationships file. */
  private String relationshipsFile;

  /** The output file. */
  private String outputFile;

  /** The is a rel. */
  private String isaRel = "116680003";

  /** The inferred char type. */
  private String inferredCharType = "900000000000011006";

  /** The root. */
  private String root = "138875005";

  /**
   * Instantiates an empty {@link TransitiveClosureGenerator}.
   */
  public TransitiveClosureGenerator() {
    // do nothing
  }

  /**
   * Sets the relationships file.
   *
   * @param relationshipsFile the relationships file
   */
  public void setRelationshipsFile(String relationshipsFile) {
    this.relationshipsFile = relationshipsFile;
  }

  /**
   * Sets the output file.
   *
   * @param outputFile the output file
   */
  public void setOutputFile(String outputFile) {
    this.outputFile = outputFile;
  }

  /**
   * Sets the isa rel.
   *
   * @param isaRel the isa rel
   */
  public void setIsaRel(String isaRel) {
    this.isaRel = isaRel;
  }

  /**
   * Sets the root.
   *
   * @param root the root
   */
  public void setRoot(String root) {
    this.root = root;
  }

  /**
   * Compute the transitive closure file.
   *
   * @throws Exception the exception
   */
  public void compute() throws Exception {
    Logger.getLogger(this.getClass().getName()).log(Level.INFO,
        "Start computing transitive closure ... " + new Date());

    if (relationshipsFile == null) {
      throw new Exception("Unexpected null relationships file.");
    }
    Logger.getLogger(this.getClass().getName()).log(Level.INFO,
        "  relationshipsFile = " + relationshipsFile);

    if (outputFile == null) {
      throw new Exception("Unexpected null output file.");
    }
    Logger.getLogger(this.getClass().getName()).log(Level.INFO,
        "  outputFile = " + outputFile);

    File rf = new File(relationshipsFile);
    if (!rf.exists()) {
      throw new Exception("relationships file does not exist.");
    }

    File of = new File(outputFile);
    if (of.exists()) {
      throw new Exception(
          "output file already exists. Please clean it up first.");
    }

    //
    // Initialize rels
    // id effectiveTime active moduleId sourceId destinationId relationshipGroup
    // typeId characteristicTypeId modifierId
    //
    Logger.getLogger(this.getClass().getName()).log(Level.INFO,
        "  Initialize relationships ... " + new Date());
    @SuppressWarnings("resource")
    PrintWriter out = new PrintWriter(new FileWriter(of));
    @SuppressWarnings("resource")
    BufferedReader in = new BufferedReader(new FileReader(rf));
    String line;
    Map<String, Set<String>> parChd = new HashMap<>();
    // skip header
    line = in.readLine();
    int ct = 0;
    while ((line = in.readLine()) != null) {
      String[] tokens = line.split("\t");
      if (tokens.length != 10) {
        throw new Exception("Unexpected number of fields in rels file "
            + tokens.length);
      }
      // Skip non isa
      if (!isaRel.equals(tokens[7])) {
        continue;
      }
      // skip non inferred rels
      if (!inferredCharType.equals(tokens[8])) {
        throw new Exception("Unexpected non inferred relationship");
      }
      String par = tokens[5];
      String chd = tokens[4];
      if (par == null || par.isEmpty()) {
        throw new Exception("Empty parent " + line);
      }
      if (chd == null || chd.isEmpty()) {
        throw new Exception("Empty child " + line);
      }
      if (!parChd.containsKey(par)) {
        parChd.put(par, new HashSet<String>());
      }
      Set<String> children = parChd.get(par);
      children.add(chd);
      ct++;
    }
    Logger.getLogger(this.getClass().getName()).log(Level.INFO,
        "      ct = " + ct);
    //
    // Write transitive closure file
    //
    Logger.getLogger(this.getClass().getName()).log(Level.INFO,
        "    Write transitive closure table ... " + new Date());
    ct = 0;
    for (String code : parChd.keySet()) {
      Logger.getLogger(this.getClass().getName()).log(Level.FINE,
          "      compute for " + code);
      
      if (root.equals(code)) {
        continue;
      }
      ct++;
      Set<String> descs = getDescendants(code, new HashSet<String>(), parChd);
      for (String desc : descs) {
        Logger.getLogger(this.getClass().getName()).log(Level.FINEST,
          code + "\t" + desc + "\r\n");
        out.print(code + "\t" + desc + "\r\n");
        out.flush();
      }
      Logger.getLogger(this.getClass().getName()).log(Level.FINE,
          "      desc ct = " + descs.size());
      if (ct % 10000 == 0) {
        Logger.getLogger(this.getClass().getName()).log(Level.INFO,
            "      " + ct + " codes processed ..." + new Date());
      }
    }
    out.close();
    in.close();
    Logger.getLogger(this.getClass().getName()).log(Level.INFO,
        "Finished computing transitive closure ... " + new Date());
  }

  /**
   * Returns the descendants.
   *
   * @param par the par
   * @param seen the seen
   * @param parChd the par chd
   * @return the descendants
   */
  public Set<String> getDescendants(String par, Set<String> seen,
    Map<String, Set<String>> parChd) {
    // if we've seen this node already, children are accounted for - bail
    if (seen.contains(par)) {
      return new HashSet<>();
    }
    seen.add(par);

    // Get Children of this node
    Set<String> children = parChd.get(par);

    // If this is a leaf node, bail
    if (children == null || children.isEmpty()) {
      return new HashSet<>();
    }

    // Iterate through children, mark as descendant and recursively call
    Set<String> descendants = new HashSet<>();
    for (String chd : children) {
      descendants.add(chd);
      Set<String> grandChildren = getDescendants(chd, seen, parChd);
      // add all recursively gathered descendants at this level
      for (String grandChidl : grandChildren) {
        descendants.add(grandChidl);
      }
    }

    return descendants;
  }

  /**
   * Application entry point. The first parameter should be the path to a
   * snapshot inferred RF2 relationships file. The second parameter should be
   * the output filename and should not yet exist.
   *
   * @param argv the command line arguments
   */
  public static void main(String[] argv) {
    try {
      TransitiveClosureGenerator generator = new TransitiveClosureGenerator();
      generator.setRelationshipsFile(argv[0]);
      generator.setOutputFile(argv[1]);
      generator.compute();
    } catch (Throwable t) {
      t.printStackTrace();
      System.exit(1);
    }
  }

}
