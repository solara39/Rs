##すべてのオブジェクトを消去する##
rm(list=ls())
##パッケ)ージの読み込み##
library(tree)
library(ISLR)

#ISLRに含まれるデータ"Carseats"を使用する#

#データをアタッチする
attach(Carseats)
#Salesが8を超えるとYes、そうでなければNoをとるカテゴリ変数Highを作成する。
High = factor(ifelse(Sales<=8,"No","Yes"))
Carseats = data.frame(Carseats,High)

##Sales以外の変数を予測変数として分類木を構築する#
tree.carseats=tree(High~.-Sales, Carseats)
summary(tree.carseats)

##計算された分類木をプロットする##
plot(tree.carseats)
text(tree.carseats,pretty=1)
#pretty=1と指定することで質的予測変数のカテゴリー名を表示する。

##データを訓練データとテストデータに分割して、テスト誤分類率を計算する##
set.seed(1234)
train = sample(1:nrow(Carseats), nrow(Carseats)/2)
Carseats.test = Carseats[-train,]
High.test = High[-train]
tree.carseats = tree(High~.-Sales,Carseats,subset=train)
tree.pred = predict(tree.carseats,Carseats.test,type="class")
pred = table(tree.pred,High.test)
pred
#誤分類率
error.rate_tree = (pred[1,2]+pred[2,1])/sum(pred)
error.rate_tree

##交差検証法により木の剪定を行う##
set.seed(1234)
cv.carseats=cv.tree(tree.carseats,FUN=prune.misclass) 
#FUN=prune.misclassとすることにより、誤分類率を基準に木の剪定を行う。デフォルトでは、逸脱度を使用している。
names(cv.carseats)
cv.carseats
#size: 終端ノードの数、k:チューニングパラメータalphaの値、dev:交差検証による誤分類数

#sizeとkの関数として誤分類数を描写する
par(mfrow=c(1,2))
plot(cv.carseats$size,cv.carseats$dev,type="b")
plot(cv.carseats$k,cv.carseats$dev,type="b")
#交差検証誤差を最小にするsizeになるように分類木を剪定する
best.size = cv.carseats$size[which(cv.carseats$dev==min(cv.carseats$dev))] 
prune.carseats=prune.misclass(tree.carseats,best=best.size)
#剪定された分類木をプロットする
par(mfrow=c(1,1))
plot(prune.carseats)
text(prune.carseats,pretty=0)
#テストデータにおける誤分類率を計算する
tree.pred=predict(prune.carseats,Carseats.test,type="class")
pred = table(tree.pred,High.test)
error.rate_cv = (pred[1,2]+pred[2,1])/sum(pred)
error.rate_cv

#size=15の分類木の誤分類率を計算する#
prune.carseats=prune.misclass(tree.carseats,best=15)
plot(prune.carseats)
text(prune.carseats,pretty=0)
tree.pred=predict(prune.carseats,Carseats.test,type="class")
pred = table(tree.pred,High.test)
error.rate_15 = (pred[1,2]+pred[2,1])/sum(pred)
error.rate_15
