CREATE MIGRATION m1ra5sid3fkeukedfru3pdl5xbglk45nsvmxb6mosdkw4bzynxiw4a
    ONTO initial
{
  CREATE ABSTRACT TYPE default::Auditable {
      CREATE PROPERTY created_at: std::datetime {
          SET default := (std::datetime_current());
          SET readonly := true;
      };
  };
  CREATE TYPE default::Actor EXTENDING default::Auditable {
      CREATE PROPERTY age: std::int16 {
          CREATE CONSTRAINT std::max_value(100);
          CREATE CONSTRAINT std::min_value(0);
      };
      CREATE PROPERTY height: std::int16 {
          CREATE CONSTRAINT std::max_value(300);
          CREATE CONSTRAINT std::min_value(0);
      };
      CREATE REQUIRED PROPERTY name: std::str {
          CREATE CONSTRAINT std::max_len_value(50);
      };
  };
  CREATE TYPE default::Movie EXTENDING default::Auditable {
      CREATE MULTI LINK actors: default::Actor;
      CREATE REQUIRED PROPERTY name: std::str {
          CREATE CONSTRAINT std::max_len_value(50);
      };
      CREATE PROPERTY year: std::int16 {
          CREATE CONSTRAINT std::min_value(1850);
      };
  };
};
