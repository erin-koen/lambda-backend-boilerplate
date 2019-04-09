// Update with your config settings.

module.exports = {

  development: {
    client: 'sqlite3',
    connection: {
      filename: './models/dev.db3'
    },
    migrations: {
      directory: './models/migrations'
    },
    seeds: {
      directory: './models/seeds'
    }
  },

  staging: {
    client: 'postgresql',
    connection: {
      database: process.env.STAGING_DB,
      user: process.env.STAGING_USER,
      password: process.env.STAGING_PW,
    },
    pool: {
      min: 2,
      max: 10
    },
    migrations: {
      tableName: 'knex_migrations'
    }
  },
  production: {
    client: 'postgresql',
    connection: {
      database: process.env.PROD_DB,
      user: process.env.PROD_USER,
      password: process.env.PROD_PW,
    }
  }
};
