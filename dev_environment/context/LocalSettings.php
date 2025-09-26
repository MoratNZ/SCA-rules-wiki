<?php
# environment variables consumed:
# SITE_NAME e.g. SCA_Lochac
# BASE_URL e.g. https://sca.org.nz
# WIKI_EMAIL e.g. wiki@sca.org.nz
# DB_URL e.g. localhost
# DB_PASSWORD- password for database
# DB_SECRET_KEY
# DB_UPGRADE_KEY

# Protect against web entry
if (!defined('MEDIAWIKI')) {
	exit;
}

# Set this as a draft wiki (enables watermarking of pdf output etc)
$makepdfIsDraft = true;

## Uncomment this to disable output compression
# $wgDisableOutputCompression = true;

$wgSitename = getenv("SITE_NAME");
$wgMetaNamespace = getenv("SITE_NAME");

## The URL base path to the directory containing the wiki;
## defaults for all runtime URL paths are based off of this.
## For more information on customizing the URLs
## (like /w/index.php/Page_title to /wiki/Page_title) please see:
## https://www.mediawiki.org/wiki/Manual:Short_URL
$wgScriptPath = "";

## The protocol and server name to use in fully-qualified URLs
$wgServer = getenv("BASE_URL");

## The URL path to static resources (images, scripts, etc.)
$wgResourceBasePath = $wgScriptPath;

## UPO means: this is also a user preference option

$wgEnableEmail = true;
$wgEnableUserEmail = false; # UPO

$wgEmergencyContact = getenv('WIKI_EMAIL');
$wgPasswordSender = getenv('WIKI_EMAIL');

$wgEnotifUserTalk = false; # UPO
$wgEnotifWatchlist = true; # UPO
$wgEmailAuthentication = true;

## Database settings
$wgDBtype = "mysql";
$wgDBserver = getenv('DB_URL');
$wgDBname = getenv('DB_NAME');
$wgDBuser = getenv('DB_USER');
$wgDBpassword = getenv("DB_PASSWORD");

# MySQL specific settings
$wgDBprefix = "";

# MySQL table options to use during installation or update
$wgDBTableOptions = "ENGINE=InnoDB, DEFAULT CHARSET=binary";

# Experimental charset support for MySQL 5.0.
$wgDBmysql5 = false;

## Shared memory settings
$wgMainCacheType = CACHE_NONE;
$wgMemCachedServers = [];

## To enable image uploads, make sure the 'images' directory
## is writable, then set this to true:
$wgEnableUploads = true;
$wgUseImageMagick = true;
$wgImageMagickConvertCommand = "/usr/bin/convert";

# InstantCommons allows wiki to use images from https://commons.wikimedia.org
$wgUseInstantCommons = false;

## If you use ImageMagick (or any other shell command) on a
## Linux server, this will need to be set to the name of an
## available UTF-8 locale
$wgShellLocale = "C.UTF-8";

## Set $wgCacheDirectory to a writable directory on the web server
## to make your wiki go slightly faster. The directory should not
## be publically accessible from the web.
#$wgCacheDirectory = "$IP/cache";

# Site language code, should be one of the list in ./languages/data/Names.php
$wgLanguageCode = "en-gb";

$wgSecretKey = getenv('DB_SECRET_KEY');

# Changing this will log out all existing sessions.
$wgAuthenticationTokenVersion = "1";

# Site upgrade key. Must be set to a string (default provided) to turn on the
# web installer while LocalSettings.php is in place
$wgUpgradeKey = getenv('UPGRADE_KEY');

## For attaching licensing metadata to pages, and displaying an
## appropriate copyright notice / icon. GNU Free Documentation
## License and Creative Commons licenses are supported so far.
$wgRightsPage = ""; # Set to the title of a wiki page that describes your license/copyright
$wgRightsUrl = "";
$wgRightsText = "";
$wgRightsIcon = "";

# Path to the GNU diff3 utility. Used for conflict resolution.
$wgDiff3 = "/usr/bin/diff3";



## Default skin: you can change the default skin. Use the internal symbolic
## names, ie 'vector', 'monobook':
$wgDefaultSkin = "vector";

# Enabled skins.
wfLoadSkin('Vector');


# Enabled extensions. Most of the extensions are enabled by adding
# wfLoadExtensions('ExtensionName');
wfLoadExtension('PdfHandler');
wfLoadExtension('MakePdfBook');
wfLoadExtension('VisualEditor');
wfLoadExtension('WikiEditor');
wfLoadExtension('TemplateData');
wfLoadExtension('ParserFunctions');
#wfLoadExtension('LabeledSectionTransclusion');

# Allow uploading of PDFs and SVGs
$wgFileExtensions = array_merge(
    $wgFileExtensions, [
	    'pdf', 'svg'
    ]
);	
# Render SVGs correctly  them correctly
$wgAllowTitlesInSVG = true;
$wgSVGNativeRendering = true;



# Debian specific generated settings
# Use system mimetypes
$wgMimeTypeFile = '/etc/mime.types';

# Allow direct setting of page titles, independent of page names 
# This is so namespaces don't have to be present in page titles
$wgAllowDisplayTitle = true;
$wgRestrictDisplayTitle = false;


$handbookNamespaces = [
	"Global" => 550,
	"Archery" => 1000,
	"Armored_Combat" => 1002, 
	"Equestrian" => 1004, 
	"Rapier" => 1006,
	"Siege" => 1008, 
	"Thrown_Weapons" => 1010, 
	"Youth_Martial" => 1012, 
	"Armored_Steel_Combat" => 1014, 
	"Cut_And_Thrust" => 1016, 
	"Harnischfechten" => 1018, 
];

$kingdoms = [
	'Model' => 100,
	'Aethelmearc' => 200, 
	'An_Tir' => 300, 
	'Ansteorra' => 400,
	'Artemisia' => 500,
    'Atenveldt' => 600,
    'Atlantia' => 700,
    'Avacal' => 800,
    'Caid' => 900,
    'Calontir' => 1000,
    # 'Drachenwald'  deliberately omitted
    'Ealdormere' => 1100,
    'East_Kingdom' => 1200,
    'Gleann_Abhann' => 1300,
    # 'Lochac   ' deliberately omitted
    'Meridies' => 1400,
    'Midrealm' => 1500,
    'Northshield' => 1600,
    'Outlands' => 1700,
    'Trimaris' => 1800,
    'West_Kingdom' => 1900,
];

# User permission settings
# General users can read, but can't edit
# They also can't create their own accounts
$wgGroupPermissions['*']['createaccount'] = false;
$wgGroupPermissions['*']['edit'] = false;
$wgGroupPermissions['*']['read'] = false;
$wgGroupPermissions['*']['delete'] = false;
$wgGroupPermissions['*']['createpage'] = false;

# Logged in users can edit the general namespace
$wgGroupPermissions['user']['read'] = true;
$wgGroupPermissions['user']['edit'] = false;
$wgGroupPermissions['user']['delete'] = false;
$wgGroupPermissions['user']['changetags'] = false;
$wgGroupPermissions['user']['applychangetags'] = false;
$wgGroupPermissions['user']['createpage'] = false;

$wgGroupPermissions['Editor'] = $wgGroupPermissions['user'];
$wgGroupPermissions['Editor']['createpage'] = true;
$wgGroupPermissions['Editor']['delete'] = true;
$wgGroupPermissions['Editor']['edit'] = true;
$wgGroupPermissions['Editor']['changetags'] = true;
$wgGroupPermissions['Editor']['applychangetags'] = true;

$wgGroupPermissions['SocietyMarshal'] = $wgGroupPermissions['Editor'];

# Create society namespaces
foreach ( $handbookNamespaces as $ns => $index ){
	$ns_name = $ns;
	$ns_index = $index;
	$ns_perms = sprintf("edit%s", str_replace("_", "", $ns_name ));

	$society_deputy_role = sprintf("Society%sEditor",str_replace("_", "", $ns_name));

	$notes = sprintf("%s_notes", $ns_name );
	$notes_index = $ns_index + 1;

	$wgExtraNamespaces[$ns_index] = $ns_name;
	$wgExtraNamespaces[$notes_index] = $notes;
	$wgContentNamespaces[] = $ns_index;
	$wgNamespacesToBeSearchedDefault[$ns_index] = true;
	$wgNamespaceProtection[$ns_index] = array($ns_perms);

	$wgGroupPermissions['SocietyMarshal'][$ns_perms] = true;

	$wgGroupPermissions[$society_deputy_role] = $wgGroupPermissions['Editor'];
	$wgGroupPermissions[$society_deputy_role][$ns_perms] = true;
}

# Create kingdom namespaces
foreach( $kingdoms as $kingdom_name => $index_offset){
	$kingdom_earl_marshal_role = sprintf("%sEarlMarshal", str_replace("_", "", $kingdom_name));

	foreach ( $handbookNamespaces as $ns => $ns_index ){
		if($ns === "Global"){
			if($kingdom_name !== "Society"){
				continue;
			}
		}
		$ns_name = $ns;
		$kingdom_name_nospaces = str_replace("_","",$kingdom_name);
		$ns_name_nospaces = str_replace("_","",$ns_name);

		$society_deputy_role = sprintf("Society%sEditor", $ns_name_nospaces);

		$ns_perms = sprintf("edit%s%s", $kingdom_name_nospaces, $ns_name_nospaces);
		$ns_editor = sprintf("%s%sEditor", $kingdom_name_nospaces, $ns_name_nospaces);
		$ns_index = $ns_index + $index_offset;
		
		$notes_name = sprintf("%s_notes", $ns_name);
		$notes_index = $ns_index + 1;

		$wgExtraNamespaces[$ns_index] = sprintf("%s_%s",$kingdom_name,$ns_name);
		$wgExtraNamespaces[$notes_index] = sprintf("%s_%s", $kingdom_name, $notes_name);
		$wgContentNamespaces[] = $ns_index;

		$wgNamespaceProtection[$ns_index] = array($ns_perms);

		if($kingdom_name === "Model"){
			$wgGroupPermissions[$society_deputy_role][$ns_perms] = true;
			$wgGroupPermissions['SocietyMarshal'][$ns_perms] = true;
		}  else {
			$wgGroupPermissions[$ns_editor] = $wgGroupPermissions['Editor'];
			$wgGroupPermissions[$ns_editor][$ns_perms] = true;
			$wgGroupPermissions[$society_deputy_role][$ns_perms] = true;
			$wgGroupPermissions[$kingdom_earl_marshal_role][$ns_perms] = true;
			$wgGroupPermissions['SocietyMarshal'][$ns_perms] = true;
		}
	}
}

// # Additional namespace definitions
// define("NS_GLOBAL", 550);
// define("NS_GLOBAL_NOTES", 551);
// $wgExtraNamespaces[NS_GLOBAL] = "Global";
// $wgExtraNamespaces[NS_GLOBAL_NOTES] = "Global_notes";
// $wgContentNamespaces[] = NS_GLOBAL;
// $wgNamespaceProtection[NS_GLOBAL] = array('editGlobal');
// $wgGroupPermissions['SiegeEditor']['editSiege'] = true;





# Namespaces can be editted by their specific editors
$wgGroupPermissions['GlobalEditor']['editGlobal'] = true;
$wgGroupPermissions['ArcheryEditor']['editArchery'] = true;
$wgGroupPermissions['ArmoredCombatEditor']['editArmoredCombat'] = true;
$wgGroupPermissions['EquestrianEditor']['editEquestrian'] = true;
$wgGroupPermissions['RapierEditor']['editRapier'] = true;
$wgGroupPermissions['RapierEditor']['editCutAndThrust'] = true;
$wgGroupPermissions['SiegeEditor']['editSiege'] = true;
$wgGroupPermissions['ThrownWeaponsEditor']['editThrownWeapons'] = true;
$wgGroupPermissions['YouthMartialEditor']['editYouthMartial'] = true;
$wgGroupPermissions['ArmoredSteelCombatEditor']['editArmoredSteelCombat'] = true;
$wgGroupPermissions['HarnischfechtenEditor']['editHarnischfechten'] = true;

$wgShowExceptionDetails = true;
$wgDebugDumpSql = true;
