# Cargar libreria.
library("recount3")
library("ggplot2")
library("edgeR")
library("limma")
library("pheatmap")

# Cargar datos a analizar.
load('processed-data/rse_ERP110263.RData')
rse_ERP110263 <- expand_sra_attributes(rse_ERP110263)

# Cambiar datos a dataframe para poder usar explore model matrix.
sampleData <- data.frame(
  Tissue = rse_ERP110263$sra_attribute.tissue_type,
  Group = rse_ERP110263$sra_attribute.Group)

# Uso de ExploreModelMatrix.
vd <- ExploreModelMatrix::VisualizeDesign(
  sampleData = sampleData,
  designFormula = ~ 0 + Tissue + Group,
  textSizeFitted = 2
)

cowplot::plot_grid(plotlist = vd$plotlist)


# Normalizacion.
dge <- DGEList(
  counts = assay(rse_ERP110263, "counts"),
  genes = rowData(rse_ERP110263)
)
dge <- calcNormFactors(dge)

# Creamos los grupos a comparar.
rse_ERP110263$grupos <- paste(rse_ERP110263$sra_attribute.tissue_type, rse_ERP110263$sra_attribute.Group)

# Visualización inicial de la expresión de los genes aunque la gran cantidad de grupos y tejidos hace
# complicado ver que corresponde a cada cosa
ggplot(as.data.frame(colData(rse_ERP110263)), aes(y = assigned_gene_prop, x = grupos)) +
  geom_boxplot() +
  theme_bw(base_size = 7) +
  ylab("Assigned Gene Prop") +
  xlab("Grupo")

mod <- model.matrix( ~ sra_attribute.tissue_type + assigned_gene_prop,
                     data = colData(rse_ERP110263)
)
colnames(mod)

# DEA con voom
vGene <- voom(dge, mod, plot = TRUE)

# Generando un heatmap
eb_results <- eBayes(lmFit(vGene))

de_results <- topTable(
  eb_results,
  coef = 2,
  number = nrow(rse_ERP110263),
  sort.by = "none"
)

# En este heatmapp veremos los 50 genes mayormente expresados.
exprs_heatmap <- vGene$E[rank(de_results$adj.P.Val) <= 50,]

df <- as.data.frame(colData(rse_ERP110263)[, c('sra_attribute.tissue_type', 'grupos')])
colnames(df) <- c('Tejido', 'Grupo')

pheatmap(
  exprs_heatmap,
  cluster_rows = TRUE,
  cluster_cols = TRUE,
  show_rownames = FALSE,
  show_colnames = FALSE,
  annotation_col = df
)
