AD構築
Terraformで設定したら簡単。

Storage Gateway用のEC2
Terraform で設定したら簡単
AMIはStorage gatewayの専用のものがある。Storage Gateway公式ドキュメントに沿ってインスタンス立ち上げ画面を開くと、
AMI-IDがでてくる。

Windows server をドメイン参加する
- NW設定でDNSサーバをドメインコントローラのIPにする
- 機能の追加でADツールをインストール
- システムマネージャで ローカルワークグループ→作成したドメインに切り替える


Storage GatewayでSMBを使う場合

- AD でStorage Gateway用のユーザを作成する
  次回ログイン時にパスワード変更が必要チェックを外す！

DHCPオプションセットを作る必要がある
https://docs.aws.amazon.com/ja_jp/vpc/latest/userguide/VPC_DHCP_Options.html#DHCPOptionSet

- VPCのDHCPオプションセットメニューからオプションセットを作成する。
  ADのドメイン、IPアドレスが必要
- VPCを選択してアクション→オプションセットで、作成したオプションセットを選ぶ
- Storage Gatewayを停止して起動する。

- Storage Gatewayから共有の作成をして、SMBの設定をする

- Windows server からのマウント設定をする
https://docs.aws.amazon.com/ja_jp/storagegateway/latest/userguide/using-smb-fileshare.html


net use F: \\10.1.1.179\storage-gatway-smb




StorageGatewayがドメイン参加できないときのトラブルシューティング
https://aws.amazon.com/jp/premiumsupport/knowledge-center/storage-gateway-domain-join-error/





ーーーー試したいことーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー
ユーザデータでドメイン参加する
https://dev.classmethod.jp/articles/add-domain-windows-with-new-hostname/


AWS Microsoft ADをAnsibleでユーザ管理する
https://qiita.com/morin_river/items/62330d02df92f2492860

AWS Storage Gateway(VPC エンドポイントあり)環境をCLIで構築し運用する手順
https://nopipi.hatenablog.com/entry/2019/12/06/022719