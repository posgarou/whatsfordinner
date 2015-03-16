# Required database_cleaner strategy for MongoDB
DatabaseCleaner[:mongoid].strategy = :truncation

# Database_cleaner strategy for neo4j
DatabaseCleaner[
    :neo4j,
    connection: {
      type: :server_db, path: 'http://localhost:7475'
    }
  ].strategy = :truncation
