# Cargar librería.
library("recount3")
# Cargar datos a analizar.
load('raw-data/rse_ERP110263.RData')


# Visualización de las características de nuestras muestras.
rse_ERP110263 <- expand_sra_attributes(rse_ERP110263)

colData(rse_ERP110263)[
  ,
  grepl("^sra_attribute", colnames(colData(rse_ERP110263)))
]

# Crear factores y numericos para posterior analisis.
rse_ERP110263$sra_attribute.Age <- as.numeric(rse_ERP110263$sra_attribute.Age)
rse_ERP110263$sra_attribute.tissue_type <- factor(tolower(rse_ERP110263$sra_attribute.tissue_type))
rse_ERP110263$sra_attribute.Group <- factor(tolower(rse_ERP110263$sra_attribute.Group))

# Variables de interés.
summary(as.data.frame(colData(rse_ERP110263)[
  ,
  grepl("^sra_attribute.[tissue_type|Group]", colnames(colData(rse_ERP110263)))
]))


# Revisamos la calidad de las muestras
rse_ERP110263$assigned_gene_prop <- rse_ERP110263$recount_qc.gene_fc_count_all.assigned / rse_ERP110263$recount_qc.gene_fc_count_all.total
summary(rse_ERP110263$assigned_gene_prop)
hist(rse_ERP110263$assigned_gene_prop)

# Podemos observar que la calidad de las muestras no es buena todas están por debajo de 0.3
table(rse_ERP110263$assigned_gene_prop < 0.3)

# Guardamos la información procesada.
save(rse_ERP110263, file = 'processed-data/rse_ERP110263.RData')




