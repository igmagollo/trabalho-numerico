interpolacao_polinomial <- function(X, Y)
{
  if (length(X) != length(Y))
  {
    cat("ERRO. length(X) != length(Y). \n")
    return(NULL)
  }
  
  # Inicialização das variaveis
  n_linhas = length(X)
  A = matrix(c(0), n_linhas, n_linhas)
  B = matrix(Y, n_linhas, 1)
  chute = matrix(c(0), n_linhas, 1)
  
  for (i in 1:n_linhas)
  {
    for (j in 1:n_linhas)
    {
      A[j,i] = X[j]^(i-1)
    }
  }
  
  # Resolução sistema linear por Gauss-Seidel
  M = Eliminacao_Gauss(A, B)
  polinomio = function(x){
    soma = 0
    for (i in 1:n_linhas)
    {
      soma = soma + M[i,1] * x^(i-1)
    }
    return(soma)
  }
  
  return(polinomio)
}