#### Bagging and Random Forests ####

##パッケージ"randomForest"のインストール##
install.packages("randomForest")
##パッケージの読み込み##
library(randomForest)
library(MASS)

##乱数のシードの設定##
set.seed(1)

##訓練データとテストデータへの分割##
train = sample(1:nrow(Boston),nrow(Boston)/2)

##バギングによる学習##
bag.boston=randomForest(medv~.,data=Boston,subset=train,mtry=13,importance=TRUE)
#mtry=13は、13個のすべての予測変数を木の各分割いおいて考えることを示しており、すなわちバギングを意味する。
#importance=TRUEとすることで、variable importanceを評価する。
#木の数はデフォルトで500になっている。変更する場合は引数ntree=xと入力する。
bag.boston

##テストデータでの性能評価##
yhat.bag = predict(bag.boston,newdata=Boston[-train,])
boston.test = Boston[-train,"medv"]
plot(yhat.bag, boston.test)
abline(0,1)
#テストデータでのMSE#
mean((yhat.bag-boston.test)^2)

##mtry=p^{1/2}としてランダムフォレストにより予測を行う##
rf.boston=randomForest(medv~.,data=Boston,subset=train,mtry=4,importance=TRUE)
yhat.rf = predict(rf.boston,newdata=Boston[-train,])
mean((yhat.rf-boston.test)^2)

#予測変数の重要度を計算する#
importance(rf.boston)
#"%IncMSE"は、与えれた変数がモデルから取り除かれたときのOOBのサンプルにおける予測精度の平均変化率である。
#"IncNodePurity"は、その変数によって得られるノードの不純度の総減少量をすべての木について平均したものである。
# 詳しくはコマンド"help("importance")"を入力して参照されたい。

#予測変数の重要度をプロットする
varImpPlot(rf.boston)

