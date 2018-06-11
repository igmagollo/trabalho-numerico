wd_atual = getwd()
setwd(getSrcDirectory(function(x) {x}))

source('Eliminacao_Gauss.R')
source('interpolacao_polinomial.R')
source('Simpson_1_3.R')
source('multi_Simpson_1_3.R')

setwd(wd_atual)

calcula_area <- function(arquivo_csv) {
	csv = read.csv(arquivo_csv, sep=',')
	escala_quadrada <- csv$YBAIXO[1]^2
	
	from = csv$X[2]
	to = max(csv$X)

	area_cima = multi_Simpson_1_3(interpolacao_polinomial(csv$X[-1],csv$YCIMA[-1]),from=from, to=to, times=length(csv$X)-1)
	area_baixo = multi_Simpson_1_3(interpolacao_polinomial(csv$X[-1],csv$YBAIXO[-1]),from=from, to=to, times=length(csv$X)-1)
	
	area_total = area_cima - area_baixo
	area_real = area_total * escala_quadrada

	return(area_real)
}
