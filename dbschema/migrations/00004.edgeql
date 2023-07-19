CREATE MIGRATION m1cxmmdcyzscwswlpnswrczjdojawgdjoccyaylgtmq2gka3sprkta
    ONTO m1ce332mbaoxkzw2cufcddsfoot3d4xrvgu7mprt5ztfyccwn2k57a
{
  ALTER TYPE default::Answer {
      DROP LINK poll;
  };
};
