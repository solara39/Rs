#### Boosting ####

##パッケージ"gbm"のインストール##
install.packages("gbm")
##パッケージの読み込み##
library(gbm)
library(MASS)

#乱数のシードの設定#
set.seed(1)
#訓練データとテストデータへの分割#
train = sample(1:nrow(Boston),nrow(Boston)/2)

##ブースティングによる予測モデルの計算##
boost.boston <- gbm(medv ~ ., data = Boston[train, ],
                    distribution = "gaussian", n.trees = 5000,
                    interaction.depth = 4)
# distribution = "gaussian"と設定することでRSS最小化を基準とする回帰問題を設定する。
# 2値分類問題の場合は、distribution = "bernoulli"を指定する。
# 引数n.trees = 5000は5,000個の木を用いることを示す。
# interaction.depth = 4により各々の木の深さを最大4に限定する。
# チューニングパラメータlambdaの値はデフォルトで0.001となっている。

##summary()関数により変数の重要度を出力する##
summary(boost.boston)
#出力結果の解釈についてはコマンド"help("summary.gbm")"で確認されたい。

##部分従属プロットを作成する##
plot(boost.boston, i = "rm")
plot(boost.boston, i = "lstat")
#詳細についてはコマンド"help("plot.gbm")"で確認されたい。

##テストデータMSEを計算する##
yhat.boost <- predict(boost.boston,
                      newdata = Boston[-train, ], n.trees = 5000)
mean((yhat.boost - boston.test)^2)

## チューニングパラメータlambdaの値を変更して学習してみる##
boost.boston <- gbm(medv ~ ., data = Boston[train, ],
                    distribution = "gaussian", n.trees = 5000,
                    interaction.depth = 4, shrinkage = 0.2)
yhat.boost <- predict(boost.boston,
                      newdata = Boston[-train, ], n.trees = 5000)
mean((yhat.boost - boston.test)^2)

