INSERT INTO `!prefix_!user_passwd` VALUES ('john', '2829fc16ad8ca5a79da932f910afad1c');

INSERT INTO `!prefix_!user_passwd` VALUES ('admin', 'a4757d7419ff3b48e92e90596f0e7548');

INSERT INTO `!prefix_!user_passwd` VALUES ('editor', '5ebe2294ecd0e0f08eab7690d2a6ee69');

INSERT INTO `!prefix_!user_passwd` VALUES ('student', '665c403aa19fe701b0ea7093ea4d0f45');


INSERT INTO `!prefix_!user_auth` VALUES ('john', 'static', 1, 1, 1, 1, 1, 1);

INSERT INTO `!prefix_!user_auth` VALUES ('admin', 'static', 1, 1, 1, 1, 1, 1);

INSERT INTO `!prefix_!user_auth` VALUES ('editor', 'static', 0, 1, 0, 1, 1, 1);

INSERT INTO `!prefix_!user_auth` VALUES ('student', 'static', 0, 0, 0, 1, 1, 1);


INSERT INTO `!prefix_!type` VALUES ('archaeology', 'Archaeologie', 'archaeology_detail.tpl', 'archaeology_edit.tpl', 'default_list.tpl', 'default_list_short.tpl', 'default_grid.tpl');

INSERT INTO `!prefix_!type` VALUES ('image', 'Bild', 'default_detail.tpl', 'default_edit.tpl', 'default_list.tpl',  'default_list_short.tpl', 'default_grid.tpl');

INSERT INTO `!prefix_!type` VALUES ('architecture', 'Architektur', 'architecture_detail.tpl', 'architecture_edit.tpl', 'default_list.tpl', 'default_list_short.tpl', 'default_grid.tpl');


INSERT INTO `!prefix_!dating_rules` VALUES ('0', 'match', '/^[[:space:]]*([[:digit:]]{2})[[:space:]]*$/', 'return _GregorianToJD( 1, 1, intval(\"19\".$match[1]) );', 'return _GregorianToJD( 12, 31, intval(\"19\".$match[1]) );', '64 == 1.1.1964 - 31.12.1964');

INSERT INTO `!prefix_!dating_rules` VALUES ('0', 'match', '/^[[:space:]]*(um|nach|vor)?[[:space:]]*([[:digit:]]{3,4})[[:space:]]*-[[:space:]]*([[:digit:]]{1,4})[[:space:]]*$/', 'return _GregorianToJD( 1,1,intval($match[2]) );', 'return _GregorianToJD( 12,31,intval(substr($match[2],0,max( 0, strlen($match[2])-strlen($match[3]))).$match[3]) );', '1875-1877 == 1.1.1875 - 31.12.1877\r\n1875-77 == 1.1.1875 - 31.12.1877\r\n1875/77 == 1.1.1875 - 31.12.1877');

INSERT INTO `!prefix_!dating_rules` VALUES ('3', 'match', '/^[[:space:]]*([[:digit:]]{1,2})[\\.]?[[:space:]]*Jh[[:space:]]*$/', 'return _GregorianToJD( 1,1,intval((intval($match[1])-1).\"00\") );', 'return _GregorianToJD( 12,31,intval((intval($match[1])-1).\"99\") );', '6. Jhdt.  == 1.1.500 - 31.12.599\r\n6. Jhdt. n Chr. == 1.1.500 - 31.12.599\r\n6 Jhd  n. Chr == 1.1.500 - 31.12.599\r\n6 Jh. n. Chr. == 1.1.500 - 31.12.599');

INSERT INTO `!prefix_!dating_rules` VALUES ('3', 'match', '/^[[:space:]]*um[[:space:]]*([[:digit:]]{3,4})[[:space:]]*$/', 'return _GregorianToJD( 1,1,intval($match[1])) - intervalFromYear( $match[1] );', 'return _GregorianToJD( 12,31,intval($match[1])) + intervalFromYear( $match[1] );', 'um 1874 == 1873 - 1875');

INSERT INTO `!prefix_!dating_rules` VALUES ('3', 'match', '/^[[:space:]]*Anf(ang)?\\.?([[:space:]]*des)?[[:space:]]*([[:digit:]]{1,2})[\\.]?[[:space:]]*Jh[[:space:]]*$/', 'return _GregorianToJD( 1,1,intval((intval($match[3])-1).\"00\") );', 'return _GregorianToJD( 12,31,intval((intval($match[3])-1).\"25\") );', 'Anfang 6. Jhdt. == 1.1.500 - 31.12.525\r\n');

INSERT INTO `!prefix_!dating_rules` VALUES ('7', 'match', '/^[[:space:]]*(um|nach|vor)?[[:space:]]*([[:digit:]]{1,2})\\.?[[:space:]]*-[[:space:]]*([[:digit:]]{1,2})\\.?[[:space:]]*Jh[[:space:]]*$/', 'return _GregorianToJD( 1,1,intval((intval($match[3])-1).\"00\") );', 'return _GregorianToJD( 12,31,intval((intval($match[2])).\"99\") );', '1. - 2. Jh. n. Chr. == 1.1.0 - 31.12.299\r\n');

INSERT INTO `!prefix_!dating_rules` VALUES ('0', 'match', '/^[[:space:]]*([[:digit:]]{3,4})[[:space:]]*vor[[:space:]]Chr\\.?[[:space:]]*$/', 'return _GregorianToJD( 1,1,-intval($match[1]) );', 'return _GregorianToJD( 12,31,-intval($match[1]) );', '1875 v. Chr. == 1.1.-1875 - 31.12.-1875');

INSERT INTO `!prefix_!dating_rules` VALUES ('0', 'match', '/^xxx[[:space:]]*(um|nach|vor)?[[:space:]]*([[:digit:]]{3,4})[[:space:]]*[-\\\\/]{1}[[:space:]]*([[:digit:]]{3,4})[[:space:]]*$/', 'return _GregorianToJD( 1,1,intval($match[2]) );', 'return _GregorianToJD( 12,31,intval($match[3]) );', '1875-1877 == 1.1.1875 - 31.12.1877');

INSERT INTO `!prefix_!dating_rules` VALUES ('3', 'match', '/^[[:space:]]*([[:digit:]]{1,2})[\\.]?[[:space:]]*Jh[[:space:]]*vor[[:space:]]*Chr\\.?[[:space:]]*$/', 'return _GregorianToJD( 1,1,-intval((intval($match[1])).\"00\") );', 'return _GregorianToJD( 12,31,-intval((intval($match[1])-1).\"01\") );', '6. Jhdt. v. Chr. == 1.1.-501 - 31.12.-600\r\n');

INSERT INTO `!prefix_!dating_rules` VALUES ('3', 'match', '/^[[:space:]]*(um|nach|vor)?[[:space:]]*([[:digit:]]{1,2})\\.?[[:space:]]*-[[:space:]]*([[:digit:]]{1,2})\\.?[[:space:]]*Jh[[:space:]]*$/', 'return _GregorianToJD( 1,1,intval((intval($match[2])-1).\"00\") );', 'return _GregorianToJD( 12,31,intval((intval($match[3])-1).\"99\") );', '6. Jhdt. n. Chr. == 1.1.500 - 31.12.599\r\n');

INSERT INTO `!prefix_!dating_rules` VALUES ('0', 'match', '/^[[:space:]]*([[:digit:]]{3,4})[[:space:]]*$/', 'return _GregorianToJD( 1,1,intval($match[1]) );', 'return _GregorianToJD( 12,31,intval($match[1]) );', '1875 n. Chr. == 1.1.1875 - 31.12.1875\r\n1875  == 1.1.1875 - 31.12.1875');

INSERT INTO `!prefix_!dating_rules` VALUES ('0', 'match', '/^[[:space:]]*(um)?[[:space:]]*([[:digit:]]+)[[:space:]]*-[[:space:]]*([[:digit:]]+)[[:space:]]*vor[[:space:]]Chr\\.?[[:space:]]*$/', 'return _GregorianToJD( 1,1,-max(intval($match[2]),intval($match[3])) );', 'return _GregorianToJD( 12,31,-min(intval($match[2]),intval($match[3])) );', '1876-1872 v. Chr. == 1.1.-1876 - 31.12.-1872');

INSERT INTO `!prefix_!dating_rules` VALUES ('3', 'match', '/^[[:space:]]*Ende([[:space:]]*des)?[[:space:]]*([[:digit:]]{1,2})[\\.]?[[:space:]]*Jh[[:space:]]*$/', 'return _GregorianToJD( 1,1,intval((intval($match[2])-1).\"75\") );', 'return _GregorianToJD( 12,31,intval((intval($match[2])-1).\"99\") );', 'Ende 6. Jhdt. == 1.1.575 - 31.12.599\r\n');

INSERT INTO `!prefix_!dating_rules` VALUES ('7', 'match', '/^[[:space:]]*(um|nach|vor)?[[:space:]]*([[:digit:]]{1,2})\\.?[[:space:]]*-[[:space:]]*([[:digit:]]{1,2})\\.?[[:space:]]*Jh[[:space:]]*vor[[:space:]]*Chr\\.?[[:space:]]*(\\\\(.*\\\\))?[[:space:]]*$/', 'return _GregorianToJD( 1,1,-intval((max(intval($match[2]),intval($match[3]))).\"00\") );', 'return _GregorianToJD( 12,31,-intval((min(intval($match[2]),intval($match[3]))-1).\"01\") );', '2. - 1. Jh. v. Chr. == 1.1.-199 - 31.12.1\r\n');

INSERT INTO `!prefix_!dating_rules` VALUES ('0', 'match', '/^[[:space:]]*um[[:space:]]*([[:digit:]]+)[[:space:]]*vor[[:space:]]Chr\\.?[[:space:]]*(\\\\(.*\\\\))?[[:space:]]*$/', 'return _GregorianToJD( 1,1,-intval($match[1]) ) - intervalFromYear( -intval($match[1]) );', 'return _GregorianToJD( 12,31,-intval($match[1]) ) + intervalFromYear( -intval($match[1]) );', 'um 1875 v. Chr. == 1.1.-1875 - 31.12.-1875');

INSERT INTO `!prefix_!dating_rules` VALUES ('3', 'match', '/^[[:space:]]*([[:digit:]]{1})\\\\.?[[:space:]]*(h\\\\.|haelfte|h�lfte)[[:space:]]*(des[[:space:]]*)?([[:digit:]]{1,2})[\\.]?[[:space:]]*Jh[[:space:]]*$/', 'return _GregorianToJD( 1,1,intval((intval($match[4])-1).\"00\")+50*(intval($match[1])-1)  );', 'return _GregorianToJD( 12,31,intval((intval($match[4])-1).\"49\")+50*(intval($match[1])-1)  );', '1. h�lfte. 6. Jhdt. == 1.1.500 - 31.12.549\r\n');

INSERT INTO `!prefix_!dating_rules` VALUES ('3', 'match', '/^[[:space:]]*([[:digit:]]{1})\\\\.?[[:space:]]*(h\\\\.|haelfte|h�lfte)[[:space:]]*(des[[:space:]]*)?([[:digit:]]{1,2})[\\.]?[[:space:]]*Jh[[:space:]]*vor[[:space:]]Chr\\.?[[:space:]]*$/', 'return _GregorianToJD( 1,1,-intval((intval($match[4])).\"00\")-50*(intval($match[1])-1)  );', 'return _GregorianToJD( 12,31,-intval((intval($match[4])-1).\"51\")-50*(intval($match[1])-1)  );', '1. h�lfte. 6. Jhdt. v. chr. == 1.1.-600 - 31.12.-551\r\n');

INSERT INTO `!prefix_!dating_rules` VALUES ('3', 'match', '/^[[:space:]]*([[:digit:]]{1})\\\\.?[[:space:]]*(v\\\\.|viertel)[[:space:]]*(des[[:space:]]*)?([[:digit:]]{1,2})[\\.]?[[:space:]]*Jh[[:space:]]*$/', 'return _GregorianToJD( 1,1,intval((intval($match[4])-1).\"00\")+25*(intval($match[1])-1)  );', 'return _GregorianToJD( 12,31,intval((intval($match[4])-1).\"24\")+25*(intval($match[1])-1)  );', '1. viertel 6. Jhdt. == 1.1.500 - 31.12.524\r\n');

INSERT INTO `!prefix_!dating_rules` VALUES ('3', 'match', '/^[[:space:]]*([[:digit:]]{1})\\\\.?[[:space:]]*(v\\\\.|viertel)[[:space:]]*(des[[:space:]]*)?([[:digit:]]{1,2})[\\.]?[[:space:]]*Jh[[:space:]]*vor[[:space:]]Chr\\.?[[:space:]]*$/', 'return _GregorianToJD( 1,1,-intval((intval($match[4])).\"00\")-25*(intval($match[1])-1)  );', 'return _GregorianToJD( 12,31,-intval((intval($match[4])-1).\"76\")-25*(intval($match[1])-1)  );', '1. viertel 6. Jhdt. v. chr == 1.1.-600 - 31.12.-576 \r\n');

INSERT INTO `!prefix_!dating_rules` VALUES ('3', 'match', '/^[[:space:]]*([[:digit:]]{1})\\\\.?[[:space:]]*(dr\\\\.|drittel)[[:space:]]*(des[[:space:]]*)?([[:digit:]]{1,2})[\\.]?[[:space:]]*Jh[[:space:]]*$/', 'return _GregorianToJD( 1,1,intval((intval($match[4])-1).\"00\")+33*(intval($match[1])-1)  );', 'return _GregorianToJD( 12,31,intval((intval($match[4])-1).\"32\")+33*(intval($match[1])-1)  );', '1. drittel 6. Jhdt. == 1.1.500 - 31.12.532\r\n');

INSERT INTO `!prefix_!dating_rules` VALUES ('3', 'match', '/^[[:space:]]*([[:digit:]]{1})\\\\.?[[:space:]]*(dr\\\\.|drittel)[[:space:]]*(des[[:space:]]*)?([[:digit:]]{1,2})[\\.]?[[:space:]]*Jh[[:space:]]*vor[[:space:]]Chr\\.?[[:space:]]*$/', 'return _GregorianToJD( 1,1,-intval((intval($match[4])).\"00\")-33*(intval($match[1])-1)  );', 'return _GregorianToJD( 12,31,-intval((intval($match[4])-1).\"68\")-33*(intval($match[1])-1)  );', '1. drittel. 6. Jhdt. v. chr == 1.1.-600 - 31.12.-568 \r\n');

INSERT INTO `!prefix_!dating_rules` VALUES ('3', 'match', '/^[[:space:]]*vor[[:space:]]*([[:digit:]]{3,4})[[:space:]]*$/', 'return _GregorianToJD( 1,1,intval($match[1])) - intervalFromYear( $match[1] );', 'return _GregorianToJD( 12,31,intval($match[1]));', 'vor 1874 == 1869 - 1874');

INSERT INTO `!prefix_!dating_rules` VALUES ('0', 'match', '/^[[:space:]]*nach[[:space:]]*([[:digit:]]+)[[:space:]]*vor[[:space:]]Chr\\.?[[:space:]]*(\\\\(.*\\\\))?[[:space:]]*$/', 'return _GregorianToJD( 1,1,-intval($match[1]) ) - intervalFromYear( -intval($match[1]) );', 'return _GregorianToJD( 12,31,-intval($match[1]) );', 'vor 1875 v. Chr. == 1.1.-1795 - 31.12.-1875');

INSERT INTO `!prefix_!dating_rules` VALUES ('3', 'match', '/^[[:space:]]*mitte[[:space:]]*(des[[:space:]]*)?([[:digit:]]{1,2})[\\.]?[[:space:]]*Jh[[:space:]]*$/', 'return _GregorianToJD( 1,1,intval((intval($match[2])-1).\"33\") );', 'return _GregorianToJD( 12,31,intval((intval($match[2])-1).\"66\") );', 'mitte 6. Jhdt. == 1.1.533 - 31.12.566\r\n');

INSERT INTO `!prefix_!dating_rules` VALUES ('3', 'match', '/^[[:space:]]*mitte[[:space:]]*(des[[:space:]]*)?([[:digit:]]{1,2})[\\.]?[[:space:]]*Jh[[:space:]]*vor[[:space:]]Chr\\.?[[:space:]]*$/', 'return _GregorianToJD( 1,1,-intval((intval($match[2])).\"00\")-66);', 'return _GregorianToJD( 12,31,-intval((intval($match[2])).\"00\")-33);', 'mitte 6. Jhdt. v. chr == 1.1.-567 - 31.12.-533 \r\n');

INSERT INTO `!prefix_!dating_rules` VALUES ('0', 'replace', '', '/zwischen[[:space:]]*([[:digit:]\\\\.]+)[[:space:]]*(und|-)/', '$1 - ', '');

INSERT INTO `!prefix_!dating_rules` VALUES ('0', 'replace', '', '/[[:space:]]*\\\\(.*\\\\)[[:space:]]*/', '', '');

INSERT INTO `!prefix_!dating_rules` VALUES ('0', 'replace', '', '/(around|ca\\\\.?|~|begonnen|ab|vor|nach)/', '', '');

INSERT INTO `!prefix_!dating_rules` VALUES ('0', 'replace', '', '/(jahrhunderts?|jhd?t?s?\\\\.?)/', 'jh', '');

INSERT INTO `!prefix_!dating_rules` VALUES ('0', 'replace', '', '/(v\\\\.|vor)[[:space:]]*(christus|chr?\\\\.?)/', 'vor chr', '');

INSERT INTO `!prefix_!dating_rules` VALUES ('0', 'replace', '', '/(n\\\\.|nach)[[:space:]]*chr\\\\.?/', '', '');

INSERT INTO `!prefix_!dating_rules` VALUES ('0', 'replace', '', '/(\\\\/|bis)/', '-', '');

INSERT INTO `!prefix_!dating_rules` VALUES ('0', 'replace', '', '/[[:space:]]+/', ' ', '');

INSERT INTO `!prefix_!dating_rules` VALUES ('0', 'replace', '', '/erstes/', '1', '');

INSERT INTO `!prefix_!dating_rules` VALUES ('0', 'replace', '', '/fr(�|ue|u)hes/', 'anfang', '');

INSERT INTO `!prefix_!dating_rules` VALUES ('0', 'replace', '', '/sp(�|ae|a)tes/', 'ende', '');

INSERT INTO `!prefix_!dating_rules` VALUES ('3', 'match', '/^[[:space:]]*um[[:space:]]*([[:digit:]]{1,2})[\\.]?[[:space:]]*Jh[[:space:]]*$/', 'return _GregorianToJD( 1,1,intval((intval($match[1])-1).\"00\") ) - intervalFromYear( intval((intval($match[1])-1).\"00\"));', 'return _GregorianToJD( 12,31,intval((intval($match[1])-1).\"99\") ) + intervalFromYear( intval((intval($match[1])-1).\"99\"));', 'um 6. Jhdt.  == 1.1.480 - 31.12.620\r\n');

INSERT INTO `!prefix_!dating_rules` VALUES ('3', 'match', '/^[[:space:]]*nach[[:space:]]*([[:digit:]]{3,4})[[:space:]]*$/', 'return _GregorianToJD( 1,1,intval($match[1]));', 'return _GregorianToJD( 12,31,intval($match[1])) + intervalFromYear( $match[1] );', 'nach 1874 == 1874 - 1875');

INSERT INTO `!prefix_!dating_rules` VALUES ('0', 'match', '/^[[:space:]]*nach[[:space:]]*([[:digit:]]+)[[:space:]]*vor[[:space:]]Chr\\.?[[:space:]]*(\\\\(.*\\\\))?[[:space:]]*$/', 'return _GregorianToJD( 1,1,-intval($match[1]) );', 'return _GregorianToJD( 12,31,-intval($match[1]) ) + intervalFromYear( -intval($match[1]) );', 'nach 1875 v. Chr. == 1.1.-1875 - 31.12.-1860');

INSERT INTO `!prefix_!dating_rules` VALUES ('0', 'replace', '', '/(gegen|vollendet)/', 'vor', '');

INSERT INTO `!prefix_!dating_rules` VALUES ('0', 'replace', '', '/letztes[[:space:]]*viertel/', '4. viertel', '');

INSERT INTO `!prefix_!dating_rules` VALUES ('0', 'replace', '', '/letztes[[:space:]]*drittel/', '3. drittel', '');

INSERT INTO `!prefix_!dating_rules` VALUES ('0', 'match', '/^[[:space:]]*([[:digit:]]{2}).([[:digit:]]{2}).([[:digit:]]{4})[[:space:]]*$/', 'return _GregorianToJD( intval( $match[1]), intval( $match[2]), intval( $match[3]) );', 'return _GregorianToJD( intval( $match[1]), intval( $match[2]), intval( $match[3]) );', '23.10.2003 == 23.10.2003 - 23.10.2003');

INSERT INTO `!prefix_!dating_rules` VALUES ('0', 'match', '/^[[:space:]]*sp�t[[:space:]]*antike[[:space:]]*$/', 'return _GregorianToJD( 1, 1, 275 );', 'return _GregorianToJD( 12, 31, 525 );', 'sp�tantike == 1.1.275 - 31.12.525');

INSERT INTO `!prefix_!dating_rules` VALUES ('0', 'match', '/^[[:space:]]*shang[[:space:]-]*dynastie[[:space:]]*$/', 'return _GregorianToJD( 1, 1, -1625 );', 'return _GregorianToJD( 12, 31, -975 );', 'Shang-Dynastie == 16 - 11 Jh. v. Chr');

INSERT INTO `!prefix_!dating_rules` VALUES ('0', 'match', '/^[[:space:]]*vor[[:space:]]*([[:digit:]]+)[[:space:]]*vor[[:space:]]Chr\\.?[[:space:]]*(\\\\(.*\\\\))?[[:space:]]*$/', 'return _GregorianToJD( 1,1,-intval($match[1]) ) - intervalFromYear( -intval($match[1]) );', 'return _GregorianToJD( 12,31,-intval($match[1]) );', 'um 1875 v. Chr. == 1.1.-1875 - 31.12.-1875');

INSERT INTO `!prefix_!dating_rules` VALUES ('0', 'match', '/^[[:space:]]*antike[[:space:]]*$/', 'return _GregorianToJD( 1, 1, -825 );', 'return _GregorianToJD( 12, 31, 525 );', 'antike == 1.1.-825 - 31.12.525');

INSERT INTO `!prefix_!dating_rules` VALUES ('0', 'replace', '', '/(u\\\\.|und|bzw\\\\.?|oder)/', ';', '');