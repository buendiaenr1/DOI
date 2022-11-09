#install.packages("xlsx")

library(rcrossref)
library(xlsx)
library(stringr)
library(pracma)

cad <- readLines(file.choose())  # buscar archivo de texto de referencias con doi estilo ncbi
n <- length(cad)
cat(" Líneas leidas : ",n,"\n")


# extraer solo el DOI y usarlo para buscar el resumen
options(show.error.messages = FALSE) # no mostrar errores

vec <- c()
resu <- c()

cont=1
while (cont <= n){
x <- strsplit(cad[cont], split = " ")
cat(" cad: ",x,"\n")
for (i in 1:length(x[[1]])) {
	try(
	if( str_detect(x[[1]][i], "doi:")){
		cc <- x[[1]][i])
		cc <- gsub(' ','',cc)       # borrar espacios
		cc <- gsub('[doi:]','',cc)  # borrar doi:
		cat(">>> DOI:",cc,"\n")
		vec <- c(vec,cc)
		rrr <- cr_abstract(doi = cc)  # extraer resumen usando el doi, usando rcrossref
		resu <- c(resu,rrr)
	})
	
}
cont=cont+1
}

# escribir los DOI
write.xlsx(vec, file="C:/Users/yo/Desktop/g_doi.xlsx", sheetName="DOI", append=FALSE)
#write.xlsx(vec, file="C:/Users/Public/Desktop/g_doi.xlsx", sheetName="DOI", append=FALSE)


# escribir los resumenes
#con <- file("C:/Users/Public/Desktop/resums_doi.txt")
con <- file("C:/Users/yo/Desktop/resums.txt")
documento <- writeLines(text = resu, con = con)
close(con)








