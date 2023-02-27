# Post-Antibiotic Gut Mucosal Microbiome Reconstitution Is Impaired by Probiotics and Improved by Autologous FMT.
*Rogelio Lael Ávila Silva*

## Introducción
A lo largo de los años el uso de probióticos para restaurar la microbiota intestinal después de un tratamiento con antibióticos se ha vuelto una práctica común a pesar de la falta de información que compruebe su efectividad e incluso podría afectar la recomposición del microbioma intestinal. Es por esto que surge la necesidad de evaluar el efecto del uso de probióticos para restaurar el microbioma intestinal después del uso de antibióticos y compararlos con otros tratamientos que han probado ser más efectivos para la restauración de la microbiota intestinal como el transplante autologo de micrbiota fecal. En este proyecto se analiza datos de RNA-seq obtenidos de diferentes partes del tracto digestivo con diferentes tratamientos y diferentes condiciones para observar los cambios a nivel de transcriptoma causados por estos tratamientos.

## Exploración de datos
Primeramente descargué los datos de la base de datos recount3 para una exploración inicial y los guardé en un objeto, provenientes de humano y de diferentes partes del tracto digestivo procedí a identificar las características del objeto tipo RSE y evaluar la calidad de los datos transcriptómicos.

![[boxplot.png]]

Para mi sorpresa, la calidad de las muestras era muy mala, como vemos en el boxplot, las muestras para cada grupo varían enormemente en su calidad y en el histograma observamos que los datos en su mayoría se encuentran en valores extremadamente bajos de lecturas. Además de errores en la anotación.

![[Quality_hist.png]]

## Análisis de expresión diferencial.

Comencé con un voom plot para observar los outliers que podría haber entre los genes pero la gráfica heredó la mala calidad de los datos y aunque podemos ver muchos outliers no podemos obtener mucha información al respecto.

![[DEA_voom.png]]

A pesar de lo poco prometedeores que resultaban los datos podemos ver que lo que se menciona en el artículo se cumple, la sección del duodeno es la que presenta más cambios en su nivel de expresión comparada a los otros grupos a lo largo de todas las diferentes condiciones.

![[heatmap.png]]

## Conclusiones
Si tomaramos este heatmap para un análisis inicial de los datos de expresión con su análisis nos daremos cuenta de que a traves de los diferentes tejidos la expresión parece homogenea, cosa que también se menciona en el artículo. 

Debido a la muy deplorable calidad de los datos y su mala anotación podemos ver que la exploración aunque concordante con los resultados expuestos en el artículo, no considero que sea muy fiable por lo menos en este experimento de transcriptómica, además la gran cantidad de grupos y tejidos no facilita la visualización. 

