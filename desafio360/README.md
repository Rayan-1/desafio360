# Projeto de Deploy

## Branches
- `main`: Branch para produção.
- `develop`: Branch para desenvolvimento.

## Fluxo de Trabalho
1. Crie uma nova branch a partir de `develop` para cada feature.
2. Faça suas mudanças e commite.
3. Abra um Pull Request (PR) para mesclar sua branch com `develop`.
4. Após revisão e aprovação, mescle o PR.
5. Periodicamente, mescle `develop` na `main` para preparar uma nova release.

## Exemplo de fluxo de trabalho
```sh
# Crie uma nova branch de feature
git checkout -b feature/nova-feature

# Faça suas mudanças e commite
git add .
git commit -m "Implementar nova feature"

# Push para o GitHub
git push origin feature/nova-feature

# Abra um Pull Request no GitHub para mesclar feature/nova-feature em develop
Prometheus: http://localhost:9090
Grafana: http://localhost:3000 (usuário/senha padrão: admin/admin)
Loki: http://localhost:3100


Desafio 360 é um projeto que demonstra a implementação de uma aplicação completa com práticas de CI/CD. Este repositório inclui uma aplicação desenvolvida em [inserir linguagem/framework], além de configurações de pipeline de CI/CD e integração com SonarCloud para análise de qualidade de código.

## Funcionalidades

- Implementação de CI/CD usando [ferramenta de CI/CD].
- Integração com SonarCloud para monitoramento da qualidade do código.
- [Outras funcionalidades da aplicação].

## Tecnologias Utilizadas

- **Linguagem/Framework**: [inserir]
- **Banco de Dados**: [inserir]
- **CI/CD**: [inserir ferramentas]
- **SonarCloud**: Para análise de qualidade de código.

## Instalação

1. Clone o repositório:
   ```bash
   git clone https://github.com/Rayan-1/desafio360.git
