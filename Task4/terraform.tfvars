# Значения переменных для terraform plan/apply.
# Заполните реальными значениями из вашего аккаунта Yandex Cloud:
#   yc iam create-token                    -> yc_token
#   yc resource-manager cloud list         -> cloud_id
#   yc resource-manager folder list        -> folder_id
#   ssh-keygen -t rsa -b 4096              -> ssh_public_key (публичная часть)

yc_token       = "ЗАМЕНИТЕ_НА_ВАШ_IAM_ТОКЕН"
cloud_id       = "b1gjb2ib1kkj8gobqc32"
folder_id      = "b1gthk4pqtpttj1q31sk"
ssh_public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE4paXawnv14lO1gJ9KUPcEq0Sq0Ql+PkABzdQvqgcIe future20-terraform"