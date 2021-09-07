create or replace PACKAGE           "SYSTEM_CONSTANTS" IS
/***********************************************************************************
* Module Name:  system_constants
* Description:  System wide constants
* Author:       Stuart Johnson
* Date Created: 17-APR-97
* Called by:    n/a
* Calls:        n/a
* Parameters:   n/a
* Source File:  system_constants.pks
* Specification Reference:  n/a
************************************************************************************
* Version   *  Amended    * Date     * Change   * Description of Change
* History   *  By         * Amended  *  Ref     *
************************************************************************************
* 0.1       *  SJ         * 17/04/97 *          * Initial Version
* 0.2       *  SB         * 07/10/97 * TI031    * added constant wallstreet_file_rej_msg
* 0.3       *  SB         * 16/10/97 * TI076    * removed system constant Status_Period_End_Run
* 0.4       *  PG         * 11/11/97 * SR0018   * Added two system constants for settlement file(s)
*           *             *          *          * settlement request(s) period.
* 0.5       *  CMG        * 30/12/97 * 60533    * Added a constant for the settlement message
*           *             *          *          * column size, so that the WallStreet rejection
*           *             *          *          * message can be truncated appropriately.
* 0.6       *  CMG        * 28/01/98 * SR0080   * Add constants for GAIT code usages (CR071)
* 0.7       *  AS         * 12/3/98  * SR0137   * Add constants for abandoning message for period end process.
* 0.8       *  AS         * 01/04/98 * SR0137   * commented the constant 'invalid_acc_period_message' and
*           *             *          *          * new errorcode is generated in hub_message.pks for generating error message.
* 0.9       *  SPB        * 30/04/98 * SR0141   * Added a system parameter constant for bringing
*           *             *          *          * forward the accounting period cut-off.
* 0.10      *  RJT        * 12/01/99 * CR0100   * Added a system parameter constant for Group Accounts ASC.
* 0.11      *  RJT        * 09/03/99 * CR0098   * Added two new system parameter constants, one to calculate
*           *             *          *          * non banking days for London instance of WallStreet and one
*           *             *          *          * to determine how long to keep non banking day records.
* 0.12      *  SMB        * 23/07/99 * CR083    * Added a new constant to identify the Dummy Accounting Centre
*           *             *          *          * record in the [hb_system_parameters] table. This is used in
*           *             *          *          * HSINP017 and HSINP027 to provide a default ACE_ID value.
* 0.13      *  SMB        * 21/02/00 * CR149    * Added a new constant which turn on/off all the PE
*           *             *          *          * Group Accounts reports (except for QF).
* 0.14      *  D.Earnshaw * 22/06/01 * SR1-T6EP * Added new HTTP_Path parameter.
* 0.15      *  D.Earnshaw * 13/07/01 * SR1-RHJM * Changed six system constants to facilitate
*           *             *          *          * the new Wallstreet 'city' - Chicago.
*           *             *          *          * Also added dummy accounts for each ledger.
* 0.16            *  S. Reid    * 07/11/01 * SR1-1ZERA * Added User Security Constants
* 0.17      *  J. Rhind   * 01/08/02 *          * Added firstFocus to standard_page_attributes
* 0.18       * S. Reid     * 13-Feb-2003* 1-5WWIL* Add link to GEM website, constant.
* 0.19      *  P. Keylock * 20/05/04 *  71-HHD  * Added HTTP_PLSQL constant
* 0.20      *  P. Keylock * 18/06/04 *          * Added HTTP_Prefix constant
* 0.21      * Bijaya      * 05/03/13 * BIJA-954FYU      * WS Automation
* 0.22      * Murali     * 04/02/15 * CRQ000000388315  * Two new system constants are added for user validation url modification for https
* 0.23      * Charudatta Joshi *18/06/2017**Added new Constant lv_treasury_spe_id, lv_treasury_asc and TREASURY_SETTLEMENT
* 2.0       * Venukumar    * 25-02-2019    * Digital Security Password requirement for Privileged Accounts to 16 Characters
***********************************************************************************/
lv_treasury_spe_id CONSTANT HB_SYSTEM_PROFILES.id%type:='TREASURY'; --cj
lv_treasury_asc    CONSTANT hb_accounting_centres.NAME%type:='BP TREASURY'; --cj

/*
** Web constants
*/
system_domain CONSTANT   VARCHAR2(200) := 'http://bphub.bpweb.bp.com';
system_dcd    CONSTANT   VARCHAR2(200) := 'hub_dev';
system_owa    CONSTANT   VARCHAR2(200) := 'owa';
system_url    CONSTANT   VARCHAR2(200) := 'http://bphub.bpweb.bp.com/hub_dev/owa/';
standard_page_attributes VARCHAR2(1000) :=
    'BGCOLOR="FFFFFF" TEXT="000000" LINK="33CC33" VLINK="33CC33" ALINK="33CC33" onload="if (window.firstFocus !=null)firstFocus();"';
/*
** Full codes for wall street instances - used by Wall St. Interface
*/
London      hb_group_companies.city_code%TYPE := 'LONDON';
Chicago     hb_group_companies.city_code%TYPE := 'CHICAGO';
CrossLedger hb_group_companies.city_code%TYPE := 'XLD';
/*
** Short codes for wall street instances - used by Wall St. Interface
*/
Ldn             VARCHAR2(3) := 'LDN';           /* London-London */
Clv             VARCHAR2(3) := 'CLV';           /* Chicago-Chicago */
Xlc             VARCHAR2(3) := 'XLC';           /* Cross-Ledger London-Chicago */
Xcl             VARCHAR2(3) := 'XCL';           /* Cross-Ledger Chicago-London */
/*
** Wall St. Interface Dummy Accounts for Cross Ledger Transactions.
** Ldn_X_Dummy is dummy account for Clv on the London Ledger
** Clv_X_Dummy is dummy account for Ldn on the Chicago Ledger
*/
Ldn_X_Dummy  VARCHAR2(10) := 'HUBC';
Clv_X_Dummy  VARCHAR2(10) := 'HUBL';
/*
** Status values and settlement messages
*/
Requested   hb_transactions.status%TYPE := 'REQUESTED';
RequestedMessage hb_transactions.settlement_comment%TYPE := 'Wall Street settlement requested';
Settled     hb_transactions.status%TYPE := 'SETTLED';
ZeroBalSettledMessage hb_transactions.settlement_comment%TYPE := 'Zero balance transaction settled by Hub';
InternalIfaSettledMessage hb_transactions.settlement_comment%TYPE := 'Hub settled internally by matching IFA';
WallStreetSettledMessage hb_transactions.settlement_comment%TYPE := 'Transaction settled by Wall Street';
WallStreetRejectedMessage hb_transactions.settlement_comment%TYPE := 'Rejection: ';
Due         hb_transactions.status%TYPE := 'DUE';
Rejected    hb_transactions.status%TYPE := 'REJECTED';
Reversed    hb_transactions.status%TYPE := 'REVERSED';
zero_balance hb_settlements.settlement_method%TYPE := 'ZERO BALANCE';
wall_street  hb_settlements.settlement_method%TYPE := 'WALL STREET';
internal_ifa hb_settlements.settlement_method%TYPE := 'INTERNAL IFA';
wallstreet_file_rej_msg hb_intray_entries.description%TYPE := ' has been rejected by WALLSTREET. Rejection reason : ';
yes             VARCHAR2(1) := 'Y';
no              VARCHAR2(1) := 'N';
end_report VARCHAR2(100) := '***** END OF DATA *****';
first_start_date hb_accounting_periods.end_date%TYPE := TO_DATE('01-JAN-1960', 'DD-MON-YYYY');
/*
** Payment methods
*/
CASH_SETTLEMENT                CONSTANT hb_transactions.payment_method%TYPE := 'CASH';
AUTO_SETTLEMENT                CONSTANT hb_transactions.payment_method%TYPE := 'WALLSTREET';
TREASURY_SETTLEMENT            CONSTANT hb_transactions.payment_method%TYPE := 'TREASURY SETTLED'; --cj
/*
** System parameter constants
*/
LondonCutoffPeriod                  hb_system_parameters.name%TYPE := 'LDNCOFF';
ChicagoCutoffPeriod               hb_system_parameters.name%TYPE := 'CLVCOFF';
LondonAdvancePeriod                 hb_system_parameters.name%TYPE := 'LDNWSDAY';   /* Days in advance a London payment request will be sent to Wall St. */
ChicagoAdvancePeriod              hb_system_parameters.name%TYPE := 'CLVWSDAY';   /* Days in advance a Chicago payment request will be sent to Wall St. */
SettlementsPerFile                  hb_system_parameters.name%TYPE := 'SETPERWS';   /* Maximum number of settlements allowed per file sent to Wall St. */
NBDAccountingCentre                 hb_system_parameters.name%TYPE := 'NBD_ASC_ID'; /* Accounting support centre to send non banking days interface intray entries to */
ERAccountingCentre                  hb_system_parameters.name%TYPE := 'ER_ASC_ID';  /* Accounting support centre to send the exchange rates interface intray entries to */
/* SMB CR083; Dummy Accounting Support Centre used as a default value when adding an ASC in HSINP017 and HSINP027 */
DummyAccountingCentre               CONSTANT hb_system_parameters.name%TYPE := 'DUM_ASC_ID';
/* SMB CR149; Column which stores flat that turns on/off Group Accounts PE reports reports*/
GrpAccsGetPE_Reports            CONSTANT hb_system_parameters.name%TYPE := 'GRP_PE_REP';
DaysToHoldUserSecurityLog           hb_system_parameters.name%TYPE := 'USLDAYS';    /* Number of days for the deletion of the entry in the hb_user_logins and hb_user_session*/
DaysToRetainStandardReports     hb_system_parameters.name%TYPE := 'SRDAYS';     /* Number of days after which the entry is to be deleted from the hb_report_files, hb_intray_entries and hb_intray_entry_lines*/
LoginAttemptsAllowed            hb_system_parameters.name%TYPE := 'LIATTPT';    /* Number of login attempts allowed */
LoginInactiveHoursLimit         hb_system_parameters.name%TYPE := 'LINAHL';     /* Timeout period in hours for an inactive user session */
EnvironmentTitle                hb_system_parameters.name%TYPE := 'ENVTITL';    /* Environment title to display at the start of each page title */
IFAMnemonicMaxLength            hb_system_parameters.name%TYPE := 'IFAMAXL';    /* Maximum length of the IFA mnemonic */
DaysToRetainDownloadFiles       hb_system_parameters.name%type := 'DTRDF';      /* Number of days for the deletion of the entry from hb_intray_entries, hb_interface_file and from the server*/
CashSettlementReversalWindow    hb_system_parameters.name%type := 'CSRWIN';     /* Number of days after after actual settment date that the settlement can be reversed */
Hub_Administrator_Name          hb_system_parameters.name%type := 'SYSADMIN';
csvrepdir                       hb_system_parameters.name%TYPE := 'CSVREPDIR';  /* Path for the output csv files directory */
DaysToRetainActionedIntray      hb_system_parameters.name%type := 'DTRAI';      /* Number of days for the deletion of the entry from hb_intray_entries which are actioned*/
Rep_rate_for_perid_end          hb_system_parameters.name%type := 'RRFPE';      /* Repeatition rate for the period end process to run */
Rep_rate_for_auto_intray        hb_system_parameters.name%type := 'RRFAI';      /* Repeatition rate for the auto intray download proces to run */
MinimumPeriodEndUpdate          hb_system_parameters.name%type := 'PDENDUPD';   /* Name of the system parameter which holds in minutes the Minimum advance warning for bringing forward Period End date */
MinimumCutOffUpdate             hb_system_parameters.name%type := 'PDCUTOFUPD'; /* Name of the system parameter which holds in minutes the Minimum advance warning for bringing forward Period Cut-off date */
Job_per_queue                   hb_system_parameters.name%type := 'PRO_TO_QUE'; /* Number of process tha a queue can handle, deciding factor to create the queue command for a group of jobs with same queue id */
HTTP_Path                       hb_system_parameters.name%type := 'HTTPPATH';   /* The path that the HTTP listener uses for accessing screens from java applets for this environment */
HTTP_PLSQL                      hb_system_parameters.name%type := 'HTTPPLSQL';  /* The module name that the HTTP listener uses for accessing PLSQL for this environment */
HTTP_Prefix                     hb_system_parameters.name%type := 'HTTPPREFIX'; /* HTTP Prefix */
EHUB_Domain                     hb_system_parameters.name%type := 'EHUBDOMAIN'; /* HTTP Domain*/
HTTP_Port                       hb_system_parameters.name%type := 'HTTPPORT';   /* The port number the HTTP listener is running on for this environment */
HUB_MAILBOX                     hb_system_parameters.name%type := 'HUBMAILBOX'; /* The hub mail box address */
MenuRefreshPeriod               hb_system_parameters.name%type := 'MNUREFRESH'; /* The name of the system parameter which determines how often the menu is refreshed */
TickerRefreshPeriod             hb_system_parameters.name%type := 'TKRREFRESH'; /* The name of the system parameter which determines how often the menu is refreshed */
BroadcastRefreshPeriod          hb_system_parameters.name%type := 'BSTREFRESH'; /* The name of the system parameter which determines how often the menu is refreshed */
TickerTapeMessage               hb_system_parameters.name%type := 'TKRTPMSG'; /* This system parameter uses the value column for duration of msg in hrs, the description column for the message and the updated_date column for msg start time */
PeriodEndBroadcastMessage       hb_system_parameters.name%type := 'PEBM';       /* The message to be generated to show the period End of a particular Period */
YrEndPurgeDelay                 hb_system_parameters.name%type := 'YPURGEHOLD'; /* The name of the system parameter which holds the number of minutes by which the Year End Purge will wait before it is executed */
Settlement_Request_Period       hb_system_parameters.name%type := 'SRP';        /* Time in hours within which the expected settlement request should be recieved*/
Settlement_Files_Period         hb_system_parameters.name%type := 'SFP';        /* Time in hours within which the expected settlement file should be recieved*/
openaccountingperiods           hb_system_parameters.name%type := 'OPENPDS';    /* Minimum open accounting periods available in Hub*/
GroupAccountsASC                hb_system_parameters.name%type := 'GRPACCASC';  /* Accounting support centre to send period end aggregation reports to*/
Wallstreet_Currency_London      hb_system_parameters.name%type := 'WSNBCRYLON'; /* WallStreet NonBanking Day Currency for London - CR0098*/
NonBankDaysPurgePeriod          hb_system_parameters.name%type := 'NBDPRGDYS';  /* Number of days to keep historic Non Banking Day records - CR0098*/
UserPasswordStore                hb_system_parameters.name%type := 'USRPASSNO';    /* Number of historical passwords stored for the purpose of testing for unique passwords. */
UserPasswordExpiry                hb_system_parameters.name%type := 'USRPASSEXP';    /* Number of days before a user password expires and must be changed */
UserLockoutPeriod                hb_system_parameters.name%type := 'USRLCKPRD';    /*     The period in minutes that the user account is disabled for after a series of incorrect login attempts.  After this period has expired, the user may log in to the system with their existing password. */
UserPasswordWarningPeriod        hb_system_parameters.name%type := 'USRPASSWRN'; /* Number of days prior to expiry that the user will be warned. */
UserSecurityEnabled                hb_system_parameters.name%type := 'USRSCRTY';     /* Toggle Password and Account Expiry features, 0=Off, 1=On. */
UserAccountExpiry                hb_system_parameters.name%type := 'USRACCEXP';     /* Toggle Password and Account Expiry features, 0=Off, 1=On. */
GemWebsiteURL                    hb_system_parameters.name%type := 'GEMURL';     /* URL of the GEM website for link of frame menu*/
LocalImageURL                   hb_system_parameters.name%type := 'LCLIMGURL';     /* Local image url*/
Periodtosendremindermail        hb_system_parameters.name%TYPE :='REMINDMAIL';
Periodtodeactivateuser          hb_system_parameters.name%TYPE :='DEACTUSER';
bpehubadminemail                hb_system_parameters.name%TYPE :='ADMINMAIL';
/** 0.21  * Added by Bijaya   * 05/03/2013 *   * WS Automation */
Wallstreet_Aggregation_Run      hb_system_parameters.name%TYPE := 'WSARUN';
Support_Eamil 		        hb_system_parameters.name%TYPE := 'WS_SUPT_E';
App_Manager_Eamil 		hb_system_parameters.name%TYPE := 'WS_APPMG_E';
App_Owner_Eamil 		hb_system_parameters.name%TYPE := 'WS_BIZOW_E';
/** 0.21  * End of addition by Bijaya   * 05/03/13 *   * WS Automation */

/** 0.22 * Added by Murali * 04/02/15  * * User Validation URL Update for https */
HTTPS_Prefix                     hb_system_parameters.name%type := 'HTTPSPRX'; /* HTTPS Prefix */
HTTPS_Port                       hb_system_parameters.name%type := 'HTTPSPORT';   /* The port number the HTTPS listener is running on for this environment */
/** 0.22 * Added by Murali * 04/02/15  * * User Validation URL Update for https */

/*
** Button Names
*/
Query_button                    constant varchar2(100) := 'Submit Report';
Clear_button                    constant varchar2(100) := 'Clear';
View_button                     constant varchar2(100) := 'View Report';
Find_button                     constant varchar2(100) := 'Find';
/*
** DailyProcessing
*/
Daily_Bal_Retain_Days    CONSTANT NUMBER := 5; /*Parameter to indicate, how many days system will retain the daily balances*/
invalid_batch_date_message constant varchar2(100) := 'Cannot perform DailyProcessing.Processing date is not valid';
/*
** PeriodEnd Processing
*/
createdBy                     hb_accounting_periods.created_by%type := 'PERIOD_END'; /*used for entries created in HB_SCHEDULE table*/
count_commit                  CONSTANT NUMBER := 10000; /* commit after this many number of transactions */
period_end_excg_rate_mess     hb_intray_entries.description%type := 'Exchange Rates has not been received'; /* while performing period end currency reporting if exchange rates are not received */
/*invalid_acc_period_message    constant varchar2(100) := 'Cannot perform PeriodEndProcessing.Error while reading Earliest Open Accounting Period.';*/
/*no_next_open_period_message   constant varchar2(200) := 'Period End Processing has been abandoned as the last open accounting period has been reached. Please add new accounting periods.';*/
/*
** Generate Reports
*/
report_queue_no CONSTANT NUMBER := 24;
US_CRY_CODE HB_CURRENCIES.CODE%TYPE := 'USD';
/*
** for hb_schedule table
*/
Hr_to_day       CONSTANT NUMBER(3)           := 24;
/*
** Program names for the scheduler
*/
SettlementAggregation CONSTANT VARCHAR(100) := 'SettlementAggregation';
/*
** Transactions
*/
transactions            HB_INTERFACE_FILES.FILE_TYPE%TYPE := 'TRN';
/*
** Non Banking Days
*/
Load_non_banking_days_user      CONSTANT VARCHAR2(12)             := 'NBD_LOAD';
Nbd_load_description            CONSTANT VARCHAR2(2000)           := 'Results of non Banking load';
Non_banking_file_type           HB_INTERFACE_FILES.FILE_TYPE%TYPE := 'NBD';
/*
** Exchange Rates
*/
exchange_rates_file_type        HB_INTERFACE_FILES.FILE_TYPE%TYPE := 'ERE';
Load_exchange_rates_user        CONSTANT VARCHAR2(12)             := 'ER_LOAD';
Er_load_description             CONSTANT VARCHAR2(2000)           := 'Results of exchange rates load';
/*
** Created_by for all the Intray_entry
*/
created_by      HB_INTRAY_ENTRIES.UPDATED_BY%TYPE       := 'SYSTEM';
/*
** for Genarate broadcast messages
*/
Broadcast_message_period_end        hb_system_parameters.name%TYPE := 'BMDBPE';
Broadcast_message_many_times        hb_system_parameters.name%TYPE := 'PEBMMT';
Broadcast_message_at_once           hb_system_parameters.name%TYPE := 'PEBMAO';
/*
** constant for clear user security log
*/
UserSecurityDeleteCommit            CONSTANT NUMBER := 1000;
/*
** Constant for maintenance of hb_system_profile_functions
*/
DoNotDelete hb_system_functions.module_name%TYPE := 'HSINP007$';
/*
** Constant for miniumn length of password
*/
MinPassword number(2) := 8;
MinPassword1 number(2) := 16;
True    CONSTANT NUMBER(1) := 1;
False CONSTANT NUMBER(1) := 0;
/*
** Transaction audit log versions
*/
Cbefore      CONSTANT    VARCHAR2(6) := 'BEFORE';
Cafter       CONSTANT    VARCHAR2(5) := 'AFTER';
Ccurrent     CONSTANT    VARCHAR2(7) := 'CURRENT';
/*
** Transaction settlement comment column size
*/
settlement_comment_len  CONSTANT    NUMBER := 60;
/*
** GAIT Code Usage
*/
GaitCodeSale hb_gait_codes.usage%TYPE := 'S';
GaitCodePurchase hb_gait_codes.usage%TYPE := 'P';
GaitCodeAny hb_gait_codes.usage%TYPE := 'A';
END system_constants;
