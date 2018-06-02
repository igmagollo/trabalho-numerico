Sassenfeld <- function(A)
{
  n_linhas = nrow(A)
  B = rep(1, times = n_linhas)
  
  for (i in 1:n_linhas)
  {
    B[i] = 0
    for (j in 1:n_linhas)
    {
      if (i != j)
        B[i] = B[i] + A[i,j]*B[j]
    }
    B[i] = B[i] / A[i,i]
  }
  if (max(B) < 1)
    return(TRUE)
  else
    return(FALSE)
}