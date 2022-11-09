#install.packages("xlsx")

library(rcrossref)
library(xlsx)
library(stringr)
library(pracma)

cad <- readLines(file.choose())  # buscar archivo de texto de referencias con doi estilo ncbi
n <- length(cad)
cat(" Líneas leidas : ",n,"\n")

vec <- c()
resu <- c()

cont=1
doicc=0


while (cont <= n){
x <- strsplit(cad[cont], split = " ")
#cat(" cad: ")
#print(x)

for (i in 1:length(x[[1]])) {
	#print(i)
	
	 cc <- x[[1]][i]
	 #print(cc)
      try(

		
	  if(length(cc)>0){
	  if(grepl("doi",cc)){
	
      
	  cc <- str_remove_all(cc," ")       # borrar espacios
	  cc <- gsub('[:doi:]','',cc)  # borrar doi:
	  cat(">>>",cc,"\n")
	  vec <- c(vec,cc)
	  doicc=doicc+1
	  #rrr <- cr_abstract(doi = cc)  # extraer resumen usando el doi, usando rcrossref
	  #resu <- c(resu,rrr)
	  }  #if
	  } #if
	,silent=FALSE)
	
}
cont=cont+1
}
cat(" n DOI= ",doicc,"\n")



# escribir los DOI
#write.xlsx(vec, file="C:/Users/yo/Desktop/g_doi.xlsx", sheetName="DOI", append=FALSE)
#write.xlsx(vec, file="C:/Users/Public/Desktop/g_doi.xlsx", sheetName="DOI", append=FALSE)
write.xlsx(vec,file="C:/Users/FACUFIAUDITORIO/Documents/g_doi.xlsx", sheetName="DOI", append=FALSE)

# escribir los resumenes
#con <- file("C:/Users/Public/Desktop/resums_doi.txt")
con <- file("C:/Users/yo/Desktop/resums.txt")
documento <- writeLines(text = resu, con = con)
close(con)




