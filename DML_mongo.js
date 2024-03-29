db.createCollection("equipamento_producao", {
   validator: {
      $jsonSchema: {
         bsonType: "object",
         required: ["id", "equipamento_producao_id", "detalhes"],
         properties: {
            id: {
               bsonType: "int",
            },
            equipamento_producao_id: {
               bsonType: "int",
            },
            detalhes: {
               bsonType: "object",
            },
         },
      },
   },
});

db.equipamento_producao.insertMany([
   {
      id: 1,
      equipamento_producao_id: 123,
      detalhes: {
         chave1: "valor1",
         chave2: "valor2",
      },
   },
   {
      id: 2,
      equipamento_producao_id: 456,
      detalhes: {
         chave1: "valor3",
         chave2: "valor4",
      },
   },
   {
      id: 3,
      equipamento_producao_id: 789,
      detalhes: {
         chave1: "valor5",
         chave2: "valor6",
      },
   }
]);