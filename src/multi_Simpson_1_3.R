multi_Simpson_1_3 <- function(f, from, to, times)
{
  distancia = (to - from) / times
  x = seq(from, to, distancia)
  
  integral = 0
  
  for (i in 2:length(x)) {
    integral = integral + Simpson_1_3(x[i-1], (x[i] + x[i-1])/2, x[i], f)
  }
  
  return(integral)
}
