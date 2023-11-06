# (g)

mse_values <- list(
  Tree = tree_mse,
  Pruned_Tree = pruned_tree_mse,
  Bagging = bag_mse,
  Random_Forest = rf_mse,
  Boosting = boost_mse
)

min_mse_model <- names(which.min(unlist(mse_values)))
min_mse_value <- min(unlist(mse_values))
min_mse_model
min_mse_value
