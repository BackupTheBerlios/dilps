CREATE TABLE `!prefix_!logfile` (

  `logid` bigint(20) NOT NULL auto_increment,

  `sessionid` varchar(34) NOT NULL default '',

  `logdate` datetime NOT NULL default '0000-00-00 00:00:00',

  `type` int(11) NOT NULL default '0',

  `subtype` int(11) NOT NULL default '0',

  `descr` varchar(255) NOT NULL default '',

  `status` int(11) NOT NULL default '0',

  PRIMARY KEY  (`logid`),

  KEY `sessionid` (`sessionid`),

  KEY `status` (`status`),

  KEY `type` (`type`,`subtype`)

);

CREATE TABLE `!prefix_!artist` (

  `id` int(10) unsigned NOT NULL auto_increment,

  `src` varchar(32) NOT NULL default '',

  `name` varchar(200) NOT NULL default '',

  `preferred_name_id` int(10) unsigned NOT NULL default '0',

  `sounds` varchar(60) NOT NULL default '',

  PRIMARY KEY  (`id`),

  KEY `name_sounds` (`name`,`sounds`),

  KEY `parentid` (`preferred_name_id`),

  KEY `sound_dx` (`sounds`),

  KEY `parentid_sounds_dx` (`preferred_name_id`,`sounds`),

  KEY `namedx` (`name`)

);

CREATE TABLE `!prefix_!collection` (

  `collectionid` bigint(20) NOT NULL auto_increment,

  `name` varchar(255) NOT NULL default '',

  `host` varchar(255) NOT NULL default 'local',

  `active` int(11) NOT NULL default '1',

  `sammlu!prefix_!ort` varchar(155) NOT NULL default '',

  `descr` varchar(255) default NULL,

  `email` varchar(255) default NULL,

  `url` varchar(255) default NULL,

  `tabelle` varchar(15) NOT NULL default '',

  `classname` varchar(25) NOT NULL default '',

  `indexfeld` varchar(15) NOT NULL default '',

  `schlagwortfeld` varchar(15) NOT NULL default '',

  `getbild` text NOT NULL,

  `include` varchar(128) NOT NULL default '',

  PRIMARY KEY  (`collectionid`),

  KEY `active` (`active`)

);

CREATE TABLE `!prefix_!config` (

  `name` varchar(40) NOT NULL default '',

  `val` varchar(120) NOT NULL default '',

  `descr` varchar(120) default NULL

);

CREATE TABLE `!prefix_!dating` (

  `collectionid` bigint(20) NOT NULL default '0',

  `imageid` bigint(20) NOT NULL default '0',

  `from` bigint(20) NOT NULL default '0',

  `to` bigint(20) NOT NULL default '0',

  `metaid` int(12) NOT NULL default '0',

  KEY `collectionid` (`collectionid`,`imageid`),

  KEY `from` (`from`),

  KEY `to` (`to`),

  KEY `fromto` (`from`,`to`)

);

CREATE TABLE `!prefix_!dating_rules` (

  `seq` int(11) NOT NULL default '0',

  `type` set('match','replace') NOT NULL default 'match',

  `regexp` text NOT NULL,

  `from` text NOT NULL,

  `to` text NOT NULL,

  `descr` text NOT NULL,

  KEY `seq` (`seq`),

  KEY `type` (`type`)

);

CREATE TABLE `!prefix_!group` (

  `id` int(11) NOT NULL default '0',
  
  `name` text NOT NULL,
  
  `parentid` int(11) NOT NULL default '0',
  
  `owner` text NOT NULL,
  
  PRIMARY KEY  (`id`)
  
);

CREATE TABLE `!prefix_!img` (

  `collectionid` bigint(20) NOT NULL default '0',

  `imageid` bigint(20) NOT NULL default '0',

  `img_baseid` bigint(20) NOT NULL default '0',

  `filename` varchar(255) NOT NULL default '',

  `width` int(11) default NULL,

  `height` int(11) default NULL,

  `xres` int(11) default NULL,

  `yres` int(11) default NULL,

  `size` int(11) default NULL,

  `magick` varchar(20) default NULL,

  `insert_date` datetime NOT NULL default '0000-00-00 00:00:00',

  `modify_date` datetime NOT NULL default '0000-00-00 00:00:00',

  PRIMARY KEY  (`collectionid`,`imageid`),

  KEY `filename_2` (`filename`),

  KEY `img_baseid` (`img_baseid`)

);

CREATE TABLE `!prefix_!img_base` (

  `img_baseid` bigint(20) NOT NULL auto_increment,

  `collectionid` bigint(20) NOT NULL default '0',

  `base` varchar(255) NOT NULL default '',

  `getbild` text NOT NULL,

  `host` varchar(80) NOT NULL default '',

  PRIMARY KEY  (`img_baseid`),

  KEY `sammlungid` (`collectionid`)

);

CREATE TABLE `!prefix_!img_group` (  

  `groupid` int(11) NOT NULL default '0',
  
  `collectionid` int(11) NOT NULL default '0',  

  `imageid` int(11) NOT NULL default '0',

  PRIMARY KEY  (`groupid`,`collectionid`,`imageid`)

);

CREATE TABLE `!prefix_!location` (

  `id` int(10) unsigned NOT NULL auto_increment,
  
  `src` varchar(32) NOT NULL default '',
  
  `source_id` varchar(15) NOT NULL default '0',
  
  `parent_source_id` varchar(15) NOT NULL default '0',
  
  `location` varchar(200) NOT NULL default '',
  
  `loc_type` varchar(60) NOT NULL default '',
  
  `hierarchy` varchar(255) NOT NULL default '',
  
  `sounds` varchar(60) NOT NULL default '',
  
  PRIMARY KEY  (`id`),
  
  UNIQUE KEY `unique_src_source_id` (`src`,`source_id`),
  
  KEY `location_sounds` (`location`,`sounds`)
);

CREATE TABLE `!prefix_!meta` (

  `collectionid` bigint(20) NOT NULL default '0',

  `imageid` bigint(20) NOT NULL default '0',

  `type` varchar(64) NOT NULL default 'image',

  `status` set('new','edited','reviewed') NOT NULL default '',

  `addition` varchar(255) default NULL,

  `title` varchar(200) default NULL,

  `dating` varchar(80) default NULL,

  `material` varchar(200) default NULL,

  `technique` varchar(200) default NULL,

  `format` varchar(40) default NULL,

  `institution` varchar(255) NOT NULL default '',

  `literature` varchar(200) default NULL,

  `page` varchar(10) NOT NULL default '',

  `figure` varchar(10) NOT NULL default '',

  `table` varchar(10) NOT NULL default '',

  `isbn` varchar(15) NOT NULL default '',

  `keyword` varchar(200) default NULL,

  `insert_date` datetime NOT NULL default '0000-00-00 00:00:00',

  `modify_date` datetime NOT NULL default '0000-00-00 00:00:00',

  `name1id` int(10) unsigned NOT NULL default '0',

  `name2id` int(10) unsigned NOT NULL default '0',

  `locationid` int(10) unsigned NOT NULL default '0',

  `exp_prometheus` tinyint(1) NOT NULL default '0',

  `exp_sid` tinyint(1) NOT NULL default '0',

  `exp_unimedia` tinyint(1) NOT NULL default '0',

  `commentary` text NOT NULL,

  `metacreator` varchar(120) NOT NULL default '',

  `metaeditor` varchar(120) NOT NULL default '',

  `imagerights` varchar(255) NOT NULL default '',

  `name1` varchar(200) default NULL,

  `name2` varchar(200) default NULL,

  `location` varchar(200) default NULL,

  `locationsounds` varchar(60) default NULL,

  `name1sounds` varchar(60) default NULL,

  `name2sounds` varchar(60) default NULL,

  `id` int(12) NOT NULL auto_increment,

  PRIMARY KEY  (`collectionid`,`imageid`),

  UNIQUE KEY `id` (`id`),

  KEY `titel` (`title`),

  KEY `isbn` (`isbn`),

  KEY `institution` (`institution`),

  KEY `stadt_inst` (`institution`),

  KEY `status` (`status`)

);

CREATE TABLE `!prefix_!type` (

  `name` varchar(64) NOT NULL default '',

  `print_name` varchar(64) NOT NULL default '',

  `detail` varchar(128) NOT NULL default 'default_detail.tpl',

  `edit` varchar(128) NOT NULL default 'default_edit.tpl',

  `list` varchar(128) NOT NULL default 'default_list.tpl',

  `list_short` varchar(128) NOT NULL default 'default_list_short.tpl',

  `grid` varchar(128) NOT NULL default 'default_grid.tpl',

  UNIQUE KEY `name` (`name`)

);

CREATE TABLE `!prefix_!session` (

  `sessionid` varchar(34) NOT NULL default '',

  `start` datetime NOT NULL default '0000-00-00 00:00:00',

  `end` datetime NOT NULL default '0000-00-00 00:00:00',

  `lastaccess` datetime NOT NULL default '0000-00-00 00:00:00',

  `ip` bigint(20) NOT NULL default '0',

  `counter` bigint(20) NOT NULL default '0',

  `active` tinyint(4) NOT NULL default '1',

  `session_data` blob NOT NULL,

  PRIMARY KEY  (`sessionid`),

  KEY `ip` (`ip`),

  KEY `start` (`start`),

  KEY `lastaccess` (`lastaccess`),

  KEY `active` (`active`),

  KEY `end` (`end`)

);

CREATE TABLE `!prefix_!user_auth` (

  `userid` varchar(100) NOT NULL,
  
  `authtype` enum('static','ldap','imap') NOT NULL default 'static',
  
  `admin` tinyint(4) NOT NULL default '0',
  
  `editor` tinyint(4) NOT NULL default '0',
  
  `addimages` tinyint(4) NOT NULL default '0',
  
  `editgroups` tinyint(4) NOT NULL default '1',
  
  `usegroups` tinyint(4) NOT NULL default '1',  
  
  `active` tinyint(4) NOT NULL default '0',
  
  PRIMARY KEY  (`userid`)
  
);


CREATE TABLE `!prefix_!user_passwd` (

  `userid` varchar(100) NOT NULL,
  
  `passwd` varchar(100) NOT NULL,
  
  PRIMARY KEY  (`userid`)
  
);