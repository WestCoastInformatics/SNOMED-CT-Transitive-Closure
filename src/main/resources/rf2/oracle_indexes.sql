WHENEVER SQLERROR EXIT -1
SET ECHO ON

CREATE INDEX x_identifier_refercompid ON identifier(referencedComponentId)
PCTFREE 10 COMPUTE STATISTICS;

CREATE INDEX x_assocrefer_refercompid ON associationreference(referencedComponentId)
PCTFREE 10 COMPUTE STATISTICS;

CREATE INDEX x_attrvalue_refercompid ON attributevalue(referencedComponentId)
PCTFREE 10 COMPUTE STATISTICS;

CREATE INDEX x_complexmap_refercompid ON complexmap(referencedComponentId)
PCTFREE 10 COMPUTE STATISTICS;

CREATE INDEX x_extendedmap_refercompid ON extendedmap(referencedComponentId)
PCTFREE 10 COMPUTE STATISTICS;

CREATE INDEX x_simplemap_refercompid ON simplemap(referencedComponentId)
PCTFREE 10 COMPUTE STATISTICS;

CREATE INDEX x_language_refercompid ON language(referencedComponentId)
PCTFREE 10 COMPUTE STATISTICS;

CREATE INDEX x_refsetdesc_refercompid ON refsetdescriptor(referencedComponentId)
PCTFREE 10 COMPUTE STATISTICS;

CREATE INDEX x_descrtype_refercompid ON descriptiontype(referencedComponentId)
PCTFREE 10 COMPUTE STATISTICS;

CREATE INDEX x_moduledepen_refercompid ON moduledependency(referencedComponentId)
PCTFREE 10 COMPUTE STATISTICS;
