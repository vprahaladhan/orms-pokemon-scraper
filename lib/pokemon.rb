class Pokemon
  attr_accessor :id, :name, :type, :db

  def initialize(id: nil, name:, type:, db:)
    @id = id
    @name = name
    @type = type
    @db = db
  end

  def self.save(name, type, db)
    sql = <<-SQL
      INSERT INTO pokemon (name, type) 
      VALUES (?, ?)
    SQL
    pokemon = Pokemon.new(name: name, type: type, db: db)
    db.execute(sql, name, type)
    pokemon.id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
  end

  def self.find(id, db)
    sql = <<-SQL
      SELECT * FROM pokemon 
      WHERE id = ?
    SQL
    row = db.execute(sql, id)[0]
    pokemon = Pokemon.new(id: row[0], name: row[1], type: row[2], db: db)
  end

end