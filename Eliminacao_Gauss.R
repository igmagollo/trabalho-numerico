Eliminacao_Gauss <- function(A,B)
{
  #### Verificação de existencia de solução ####
  if (nrow(A) != ncol(A))
  {
    cat("Matriz coeficiente não é quadrada \n")
    return(NULL)
  }
  
  if (ncol(A) != nrow(B))
  {
    cat("ncol da matriz coeficiente diferente de nrow da matriz solução \n")
    return(NULL)
  }
  
  temZeros = FALSE
  for (i in 1:nrow(A))
    if (A[i,i] == 0)
      temZeros = TRUE
    
  if (temZeros)
  {
    cat("Zeros na diagonal principal \n")
    return(NULL)
  }
  
  if (det(A) == 0)
  {
    cat("Determinante igual a zero \n")
    return(NULL)
  }
  
  #### Triangulação da matriz ####
  for (i in 1:nrow(A))
  {
    for (j in 1:nrow(A))
    {
      if (i < j)
      {
        multiplicador = A[j,i] / A[i,i]
        for (k in i:nrow(A))
        {
          A[j,k] = A[j,k] - multiplicador * A[i,k]
        }
        B[j] = B[j] - multiplicador * B[i]
      }
    }
  }
  
  #### Aplicação do método ####
  matriz_solucao = matrix(c(0),nrow(A),1)
  for (i in nrow(A):1)
  {
    for (j in 1:nrow(A))
    {
      if(i != j)
        matriz_solucao[i,1] = matriz_solucao[i,1] + A[i,j] * matriz_solucao[j,1]
    }
    matriz_solucao[i,1] = B[i,1] - matriz_solucao[i,1]
    matriz_solucao[i,1] = matriz_solucao[i,1] / A[i,i]
  }
  
  return(matriz_solucao)
}
