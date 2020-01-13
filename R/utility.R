print.bt_log = function(x){
  print(x$output)
}

print.bt_stones = function(x){
  cat("Marginal Log-likelihood: ", x$marginal_likelihood)
}

print.bt_model = function(x){
  cat(x)
}
