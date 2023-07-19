# dbschema/default.esdl

module default {
  type Poll {
    required property question -> str {
      constraint max_len_value(100);
    }
    property description -> str {
      constraint max_len_value(1000);
    }
    property created_at -> datetime {
      readonly := true;
      default := datetime_of_statement();
    }
    property updated_at -> datetime {
      readonly := true;
      default := datetime_current();
    }
    multi link answers -> Answer;
  }

  type Answer {
    required property text -> str {
      constraint max_len_value(100);
    }
    required property votes -> int64 {
      default := 0;
    }
  }
}
