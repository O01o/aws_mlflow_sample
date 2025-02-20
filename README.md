# AWS+MLflow+PyTorchではじめる機械学習(Terraform版)

## 実行手順

1. 本リポジトリをローカルにクローン  
2. AWSコンソール上でEC2に遷移
3. キーペアを作成してローカルに保存
4. ソースコードの`modules/aws`配下に`terraform.tfvars`を追加し、アクセスキーやキーペア名等の変数を設定
5. 以下のコマンドを入力してリソースを起動
```
terraform init
terraform plan
terraform apply
```
6. AWSコンソール上からTracker側のインスタンスにSSH接続（EC2 Instance Connect Endpoint）
7. 以下のコマンドを入力してパッケージインストール
```
curl -sSfL https://rye-up.com/get | RYE_INSTALL_OPTION="--yes" bash
source "$HOME/.rye/env"
rye init
rye add mlflow
rye sync
```
8. mlflowサービスを起動
```
rye run mlflow server --host 0.0.0.0 --port 5000
```
9. 同様にAWSコンソール上からML側のインスタンスにSSH接続（EC2 Instance Connect Endpoint）
10. 以下のコマンドを入力してパッケージインストール
```
curl -sSfL https://rye-up.com/get | RYE_INSTALL_OPTION="--yes" bash
source "$HOME/.rye/env"
rye init
rye add mlflow
rye sync
```
11. 以下のコマンドを入力してPyTorchのサンプルリポジトリを導入
```
git clone https://github.com/O01o/pytorch_mlflow_sample.git
cd pytorch_mlflow_sample/
rye sync
```
12. MNISTからサンプル画像をいくらか拝借
```
rye run python image_extractor.py
```
13. 学習プログラムを起動
```
rye run python train.py <Tracker側インスタンスのプライベートIP> 5000
```
14. ローカル端末側でEC2 Instance Connect Endpointに接続
```
aws ec2-instance-connect open-tunnel --instance-id <Tracker側インスタンスのインスタンスID> --remote-port 22 --local-port 2222
```
15. ローカル端末側で別セッションを起動し、SSH起動
```
ssh -i <ローカルに保存したキーペアのパス> <Tracker側インスタンスのLinuxユーザ名>@localhost -p 2222 -L 5000:localhost:5000
```
16. ローカル端末側でブラウザを開き、以下のURLにアクセス
```
localhost:5000
```
17. モデルメトリクスにアクセスし、損失推移を確認