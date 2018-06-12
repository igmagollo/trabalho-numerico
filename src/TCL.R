TCL <- function(A)
{
  # Calculo número de linhas de A, consequentemente, o numero de culunas
  # também, uma vez que assumimos que A é matriz quadrada 
  n_linhas <- nrow(A)
  
  # Inicialização do vetor y com n_linhas zeros
  y <- rep(0, times = n_linhas)
  
  # Calculo de cada yk
  for (i in 1:n_linhas) 
  {
    for (j in 1:n_linhas)
    {
      if (i != j)
        y[i] = y[i] + abs(A[i,j])
    }
    y[i] = y[i] / abs(A[i,i])
  }
  
  # Verificação da condição de existência
  if (max(y) < 1)
    return(TRUE)
  else
    return(FALSE)
}
