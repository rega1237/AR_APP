# Ensure an admin user exists
User.find_or_create_by!(email_address: "admin@example.com") do |u|
  u.password = "password"
end
puts "✅ Admin user created: admin@example.com / password"

# Create a sample Client if none exists
client = Client.find_or_create_by!(slug: "el-bife") do |c|
  c.name = "El Bife Steakhouse"
  c.contact_email = "contacto@elbife.example.com"
  c.contact_phone = "555-123-4567"
end
puts "✅ Client created: #{client.name} (/v/#{client.slug})"

# Create a sample Menu
menu = Menu.find_or_create_by!(client: client, name: "Menú Principal") do |m|
  m.description = "Nuestros mejores cortes y guarniciones"
end
puts "✅ Menu created: #{menu.name}"

# Create Categories
starters = Category.find_or_create_by!(menu: menu, name: "Entradas")
mains = Category.find_or_create_by!(menu: menu, name: "Cortes Principales")
puts "✅ Categories created"

# Create Dishes
Dish.find_or_create_by!(category: starters, name: "Empanada de Carne") do |d|
  d.description = "Empanada tradicional horneada al momento."
  d.price = 45.0
end

Dish.find_or_create_by!(category: mains, name: "Ribeye 400g") do |d|
  d.description = "Corte jugoso calidad Angus con guarnición a elegir."
  d.price = 550.0
end
puts "✅ Dishes created"
