# config/initializers/solid_database_connections.rb
#
# In our production environment, we are using a single database. The Solid
# gems default to a multi-database configuration (looking for :queue, :cache,
# and :cable databases). This initializer forces all of them to use the
# single :primary database connection, aligning the code with our configuration.
if Rails.env.production? || Rails.env.deployment?
  SolidQueue::Record.connects_to database: { writing: :primary, reading: :primary }
  SolidCache::Record.connects_to database: { writing: :primary, reading: :primary }
  SolidCable::Record.connects_to database: { writing: :primary, reading: :primary }
end