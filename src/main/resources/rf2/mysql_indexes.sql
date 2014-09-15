-- Show warnings after every statement.
\W

CREATE INDEX x_identifier_refercompid ON identifier(referencedComponentId);

CREATE INDEX x_assocrefer_refercompid ON associationreference(referencedComponentId);

CREATE INDEX x_attrvalue_refercompid ON attributevalue(referencedComponentId);

CREATE INDEX x_complexmap_refercompid ON complexmap(referencedComponentId);

CREATE INDEX x_extendedmap_refercompid ON extendedmap(referencedComponentId);

CREATE INDEX x_simplemap_refercompid ON simplemap(referencedComponentId);

CREATE INDEX x_language_refercompid ON language(referencedComponentId);

CREATE INDEX x_refsetdesc_refercompid ON refsetdescriptor(referencedComponentId);

CREATE INDEX x_descrtype_refercompid ON descriptiontype(referencedComponentId);

CREATE INDEX x_moduledepen_refercompid ON moduledependency(referencedComponentId);
