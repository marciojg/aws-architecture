(Subir base S3)

1. Entre na pasta 'S3' com o comando `cd terraform/S3`
2. Execute o comando `terraform init`
3. Execute o comando `terraform apply -auto-approve`
4. Saia da pasta com `cd ..`

(Subir SNS)
5. Execute o comando `terraform init`
6. Execute o comando `terraform apply -auto-approve`

(Subir API Gateway e Lambda 1)
7. Vá para a pasta serveless `cd ../serveless`
8. Crie uma pasta chamada `layer` utilizando o comando no terminal `mkdir layer`
9. Execute o comando `pip3 install -r requirements.txt -t layer` para instalar todas as dependencias listadas no arquivo `requirements.txt` dentro da pasta layer.
10. No arquivo `serveless.yml` substitua '<ARN-SNS-AQUI>' pelo ARN do SNS criado pelo terraform
10. Fazer deploy `sls deploy`



----------------------------------------

1. Criar serveless Execute um `sls deploy`
2. Copia os endereços que aparecerem, e substitua nas urls abaixo, e execute

```bash
  # /book/create
  
  curl --location --request POST '<URL-SEM-PATH>/book/create' \
--header 'Content-Type: application/json' \
--data-raw '{
 "book_name":"harry potter",
 "book_id": 34577,
 "book_preco": 45.87
}
'

  # /sell/book
  
  curl --location --request POST '<URL-SEM-PATH>/sell/book' \
--header 'Content-Type: application/json' \
--data-raw '{
 "book_name":"harry potter",
 "book_id": 34577,
 "book_preco": 45.87
}
'
```

3.

usar os iniciais aqui pra criar o s3 para manter o state do terraform
1. Execute o comando `cd ~/environment/Hackaton-exercises-terraform/demos/State/` para entrar na pasta do exercicío.'
2. Entre na pasta 'S3' com o comando `cd S3`
3. Execute o comando `terraform init`
4. Utilizando o IDE altere o aquivo 's3.tf' que esta em '/Hackaton-exercises-terraform/demos/State/S3'. Coloque sua turma e seu rm noo locais indicados. Sem espaços e sem letras maiúsculas. Isso é necessário pois os nomes de buckets são unicos em toda a AWS não só em sua conta. 
5. Execute o comando `terraform apply -auto-approve`
6. Você acabou de criar o bucket que lhe servirá de estado remoto
7. Saia da pasta com `cd ..`
8. Entre na pasta 'test' com o comando `cd test`
9.  Utilizendo o IDE altere o arquivo state.tf que esta no diretório '/Hackaton-exercises-terraform/demos/State/test'. No campo bucket coloque o mesmo nome que utilizou para criar o bucket acima.
10. Utilize o comando `terraform init` para sincronizar com o estado remoto
11. Execute o comando `terraform apply -auto-approve`
12. Se for agora no bucket do S3 que criou para o exercicio você poderá ver que foi criado um arquivo com o nome teste. Nele constam todas as indormações de tudo que o terraform executou dentro da pasta test. Verifique baixando o arquivo e lendo.
    ![images/states3.png](images/states3.png)
13. Execute o comando `rm -rf .terraform` para remover todos os arquivos de estado local do terraform
14. Execute novamente `terraform init`, dessa vez além de baixar os plugins e providers também baixou o ultimo estado da sua infraestrutura.
15. Execute o comando `terraform apply -auto-approve`. Note que nada foi alterado ou adiiconado já que sua maquina ainda esta disponivel e o terraform descobriu isso via estado remoto.
    ![apply](images/apply0.png)
16. Execute o comando `terraform destroy -auto-approve`


```sh
# Remove possível estado remoto ou atual, se houver
rm -rf .terraform

# inicia Terraform para carregar o estado remoto s3
terraform init

# Cria workspaces
terraform workspace new dev
terraform workspace new homol
terraform workspace new prod

# Lista as workspaces
terraform workspace list

# Seleciona e sobe as 2 instâncias de ec2
terraform workspace select dev
terraform apply -auto-approve

# Seleciona e sobe as 2 instâncias de ec2
terraform workspace select homol
terraform apply -auto-approve

# Seleciona e sobe as 2 instâncias de ec2
terraform workspace select prod
terraform apply -auto-approve

# Seleciona e derruba as 2 instâncias de ec2
terraform workspace select dev
terraform destroy -auto-approve

# Seleciona e derruba as 2 instâncias de ec2
terraform workspace select homol
terraform destroy -auto-approve

# Seleciona e derruba as 2 instâncias de ec2
terraform workspace select prod
terraform destroy -auto-approve

```
