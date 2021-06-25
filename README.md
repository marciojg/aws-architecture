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