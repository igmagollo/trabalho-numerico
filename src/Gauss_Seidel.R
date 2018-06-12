Gauss_Seidel <- function(A, B, chute = matrix(c(0),nrow(A),1), erro1, erro2)
{
  #### Verificação de existência de solução ####
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
  
  if (ncol(A) != nrow(chute))
  {
    cat("ncol da matriz coeficiente diferente de nrow do chute \n")
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
  
  if (!TCL(A))
  {
    cat("TCL não satisfeito \n")
    if (!Sassenfeld(A))
    {
      cat("Sassenfeld não satisfeito \n")
      return(NULL)
    }
    cat("Sassenfeld satisfeito")
  }
  
  
  #### Inicialização das variaveis do escopo da função ####
  erro1_atual = 1
  erro2_atual = 1
  vetor_erros1 = rep(1, times = nrow(A))
  vetor_erros2 = rep(1, times = nrow(A))
  contador_iteracao = 0
  
  #### Método de Gauss-Seidel ####
  while (erro1_atual > erro1 && erro2_atual > erro2)
  {
    contador_iteracao = contador_iteracao + 1
    
    for (i in 1:nrow(A))
    {
      soma = 0
      for (j in 1:nrow(A))
      {
        if(j != i)
          soma = soma + A[i,j] * chute[j,1] 
      }
      
      novo_chute = (B[i,1] - soma) / A[i,i]
      vetor_erros2[i] = abs(chute[i,1] - novo_chute)
      
      # Atualização do chute
      chute[i,1] = novo_chute
    }
    
    for (i in 1:nrow(A))
    {
      soma = 0
      for (i in 1:nrow(A))
      {
        soma = soma + A[i,j] * chute[j,1]
      }
      
      vetor_erros1[i] = abs(B[i,1] - soma)
    }
    
    # Atualização dos erros
    erro1_atual = max(vetor_erros1)
    erro2_atual = max(vetor_erros2)
  }
  
  cat(contador_iteracao, " iterações necessárias \n")
  return(chute)
}
