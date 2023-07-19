CREATE MIGRATION m1hil6ypagfhnqc67hsgy7teelj3vn4pj2na72xqq52krxnzsaw4sa
    ONTO m1ra5sid3fkeukedfru3pdl5xbglk45nsvmxb6mosdkw4bzynxiw4a
{
  ALTER TYPE default::Auditable {
      DROP PROPERTY created_at;
  };
  ALTER TYPE default::Actor {
      DROP PROPERTY age;
      DROP PROPERTY height;
      DROP PROPERTY name;
  };
  DROP TYPE default::Movie;
  DROP TYPE default::Actor;
  CREATE TYPE default::Answer {
      CREATE PROPERTY created_at: std::datetime {
          SET default := (std::datetime_current());
          SET readonly := true;
      };
      CREATE REQUIRED PROPERTY text: std::str {
          CREATE CONSTRAINT std::max_len_value(100);
      };
  };
  CREATE TYPE default::Poll {
      CREATE MULTI LINK answers: default::Answer;
      CREATE PROPERTY created_at: std::datetime {
          SET default := (std::datetime_current());
          SET readonly := true;
      };
      CREATE PROPERTY description: std::str {
          CREATE CONSTRAINT std::max_len_value(1000);
      };
      CREATE REQUIRED PROPERTY question: std::str {
          CREATE CONSTRAINT std::max_len_value(100);
      };
      CREATE PROPERTY updated_at: std::datetime {
          SET default := (std::datetime_current());
          SET readonly := true;
      };
  };
  ALTER TYPE default::Answer {
      CREATE REQUIRED LINK poll: default::Poll;
  };
  DROP TYPE default::Auditable;
};
