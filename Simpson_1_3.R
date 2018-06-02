Simpson_1_3 <- function(x0, x1, x2, f)
{
  X = c(x0, x1, x2)
  Y = c(f(x0), f(x1), f(x2))
  f_simpson <- interpolacao_polinomial(X,Y)
  h = (x2 - x0) / 2
  
  integral = h/3 * (f_simpson(x0) + 4*f_simpson(x1) + f_simpson(x2))
  
  return(integral)
}