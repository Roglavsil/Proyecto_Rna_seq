# Cargar librerias
library("recount3")

# Modificar URL.
getOption(
  "recount3_url",
  "http://duffel.rail.bio/recount3"
)
options(recount3_url = "https://recount-opendata.s3.amazonaws.com/recount3/release")

# Obtener los datos crudos. (Personalized microbiome and host features resist...)
proj_info <- subset(
  available_projects(organism = 'human'),
  project == "ERP110263" & project_type == "data_sources"
)
# Creación de objeto RSE para poder observar mejor los datos.
rse_ERP110263 <- create_rse(proj_info)

# Convertir cuentas por nucleotido a cuentas por lectura.
assay(rse_ERP110263, "counts") <- compute_read_counts(rse_ERP110263)

# Salvar los datos crudos
save(rse_ERP110263, file = 'raw-data/rse_ERP110263.RData')
