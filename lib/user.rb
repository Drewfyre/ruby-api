class User
    include DataMapper::Resource

    property :id, Serial
    property :name, String
    property :first_name, String
    property :email, String
    property :created_at, DateTime
    property :updated_at, DateTime

    validates_presence_of :name, message: "Name cannot be blank"
    validates_presence_of :email, message: "Email cannot be blank"
end