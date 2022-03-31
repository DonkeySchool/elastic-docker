1 /  produits par nom battery (fuzzy)


GET /products3/_search
{
  "sort": [
    {
      "price": {
        "order": "asc"
      }
    }
  ], 
  "query": {
    "match": {
      "name": {
        "query": "battery", 
        "fuzziness": 1
        
      }
    }
  }
}

2 / par nom + prix entre 5 et 10


GET /products3/_search
{
  "query": {
    "bool": {
      "must": [
        {
          "match": {
            "name": {
              "query": "battery",
              "fuzziness": 1
            }
          }
        }
      ],
      "filter": [
        {
          "range": {
            "price": {
              "gte": 5,
              "lte": 10
            }
          }
        }
      ]
    }
  }
}

3 / par nom + prix entre 5 et 10 - marque Lenmar


GET /products3/_search
{
  "query": {
    "bool": {
      "must": [
        {
          "match": {
            "name": {
              "query": "battery",
              "fuzziness": 1
            }
          }
        }
      ],
      "must_not": [
        {
          "term": {
            "manufacturer": 
              "Lenmar"
            
          }
        }
      ],
      "filter": [
        {
          "range": {
            "price": {
              "gte": 5,
              "lte": 10
            }
          }
        }
      ]
    }
  }
}

4 / par nom + prix entre 5 et 10 - marques Lenmar et PNY


GET /products3/_search
{
  
  "query": {
    "bool": {
      "must": [
        {
          "match": {
            "name": {
              "query": "battery",
              "fuzziness": 1
            }
          }
        }
      ],
      "must_not": [
        {
          "terms": {
            "manufacturer": [
              "Lenmar",
              "PNY"
            ]
          }
        }
      ],
      "filter": [
        {
          "range": {
            "price": {
              "gte": 5,
              "lte": 10
            }
          }
        }
      ]
    }
  }
}


5 / par nom + prix entre 5 et 10 - marques Lenmar et PNY + categorie   "Rechargeable Batteries"

GET /products3/_search
{
  "query": {
    "bool": {
      "must": [
        {
          "match": {
            "name": {
              "query": "battery",
              "fuzziness": 1
            }
          }
        },
        {
          "nested": {
            "path": "category",
            "query": {
              "bool": {
                "must": [
                  {
                    "match": {
                      "category.name": {
                        "query": "Rechargeable Batteries",
                        "operator": "and"
                      }
                    }
                  }
                ]
              }
            }
          }
        }
      ],
      "must_not": [
        {
          "terms": {
            "manufacturer": [
              "Lenmar",
              "PNY"
            ]
          }
        }
      ],
      "filter": [
        {
          "range": {
            "price": {
              "gte": 5,
              "lte": 10
            }
          }
        }
      ]
    }
  }
}