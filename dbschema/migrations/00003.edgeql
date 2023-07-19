CREATE MIGRATION m1ce332mbaoxkzw2cufcddsfoot3d4xrvgu7mprt5ztfyccwn2k57a
    ONTO m1hil6ypagfhnqc67hsgy7teelj3vn4pj2na72xqq52krxnzsaw4sa
{
  ALTER TYPE default::Answer {
      DROP PROPERTY created_at;
  };
  ALTER TYPE default::Poll {
      ALTER PROPERTY created_at {
          SET default := (std::datetime_of_statement());
      };
  };
};
