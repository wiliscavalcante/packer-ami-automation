# Golden Image Factory com Packer e AWS Systems Manager

## Descrição do Projeto

Este projeto fornece uma solução automatizada para criar Amazon Machine Images (AMIs) utilizando o Packer em conjunto com o AWS Systems Manager para provisionamento e configuração. As imagens criadas seguem as melhores práticas e padrões de segurança recomendados pela AWS.

O Terraform é usado para provisionar todas as permissões necessárias na AWS, permitindo que o Packer construa a imagem sem necessidade de permissões manuais.

## Recursos Provisionados via Terraform

Os seguintes recursos são provisionados pelo Terraform para facilitar a criação de AMIs com o Packer e o AWS Systems Manager:

- **IAM Role**: Permite que o Packer e o SSM executem ações na AWS.
- **IAM Policies**: Definem as permissões da IAM Role.
- **Instance Profile**: Associado à IAM Role para permitir que instâncias EC2 executem ações necessárias durante o build do Packer.

## Pré-Requisitos

- AWS CLI configurada com permissões apropriadas
- Terraform instalado localmente
- Packer instalado localmente

## Como Usar

### Configurando o Ambiente com Terraform

Inicialize o Terraform e aplique o plano para criar as permissões necessárias na AWS:

```bash
cd terraform
terraform init
terraform apply
```

### Construindo AMI com Packer

Com as permissões criadas, você pode agora construir a AMI:

```bash
cd ../packer
packer build -var-file=variables.json packer.json
```


## Referência

Este projeto foi inspirado pelo método descrito no AWS Blog: [Creating Packer images using Systems Manager Automation](https://aws.amazon.com/pt/blogs/mt/creating-packer-images-using-system-manager-automation/).

**Nota**: Este documento fornece um guia geral. Para mais detalhes e configurações específicas, consulte a documentação oficial do [Terraform](https://www.terraform.io/docs/index.html) e do [Packer](https://www.packer.io/docs/index.html).
