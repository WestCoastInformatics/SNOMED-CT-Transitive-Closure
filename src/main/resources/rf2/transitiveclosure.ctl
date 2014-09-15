options (skip=1,direct=true)
load data
characterset UTF8 length semantics char
infile 'Snapshot/Refset/Content/der2_cRefset_AssociationReferenceSnapshot_${editionLabel}_${editionVersion}.txt' "str X'0d0a'"
badfile 'associationreference.bad'
discardfile 'associationreference.dsc'
insert
into table associationreference
reenable disabled_constraints
fields terminated by X'09'
trailing nullcols
(
    id CHAR(52),
    effectiveTime DATE "YYYYMMDD",
    active INTEGER EXTERNAL,
    moduleId INTEGER EXTERNAL,
    refsetId INTEGER EXTERNAL,
    referencedComponentId INTEGER EXTERNAL,
    targetComponent INTEGER EXTERNAL
)