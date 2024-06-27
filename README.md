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
