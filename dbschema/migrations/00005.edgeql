CREATE MIGRATION m1gb6v4utc6d23tfala34s7xi2wnmwcsp3dmlubtovl4pyivskkeua
    ONTO m1cxmmdcyzscwswlpnswrczjdojawgdjoccyaylgtmq2gka3sprkta
{
  ALTER TYPE default::Answer {
      CREATE REQUIRED PROPERTY votes: std::int64 {
          SET default := 0;
      };
  };
};
