# Duplicated Code Analysis Report

This document identifies duplicated code patterns across the codebase with reasoning for each suggestion.

## 1. DataTables Asset Loading (High Priority)

**Location:** Multiple controllers
- `app/controllers/ServerController.php` (lines 142-162)
- `app/controllers/MemberController.php` (lines 32-53)
- `app/controllers/LogController.php` (multiple locations: lines 43-64, 90-111, 147-168, 203-221, 272-292)

**Duplication Pattern:**
The same 13 JavaScript files and 3 CSS files for DataTables are loaded identically across multiple action methods.

**Example:**
```php
// Repeated in multiple places
$this->assets->addJs("adminlte/plugins/datatables/jquery.dataTables.min.js");
$this->assets->addJs("adminlte/plugins/datatables-bs4/js/dataTables.bootstrap4.min.js");
// ... 11 more JS files
$this->assets->addCss("adminlte/plugins/datatables-bs4/css/dataTables.bootstrap4.min.css");
// ... 2 more CSS files
```

**Reasoning:**
- Violates DRY (Don't Repeat Yourself) principle
- Makes maintenance difficult - any change requires updating multiple locations
- Increases code size unnecessarily
- Should be extracted to a helper method in `ControllerUIBase`

**Recommendation:**
Create a method `loadDataTablesAssets()` in `ControllerUIBase` and call it from action methods.

---

## 2. forward() Method Duplication

**Location:**
- `app/controllers/ControllerBase.php` (lines 12-23)
- `app/controllers/ControllerUIBase.php` (lines 27-38)

**Duplication Pattern:**
Identical `forward()` method implementation in both base classes.

**Code:**
```php
protected function forward($uri)
{
    $uriParts = explode('/', $uri);
    $params = array_slice($uriParts, 2);
    return $this->dispatcher->forward(
        array(
            'controller' => $uriParts[0],
            'action' => $uriParts[1],
            'params' => $params
        )
    );
}
```

**Reasoning:**
- `ControllerUIBase` extends `Controller`, not `ControllerBase`, so it can't inherit the method
- Both classes need this functionality
- Should be in a shared trait or `ControllerUIBase` should extend `ControllerBase`

**Recommendation:**
Either:
1. Make `ControllerUIBase` extend `ControllerBase` instead of `Controller`
2. Create a trait with the `forward()` method
3. Move to a shared utility class

---

## 3. getUserService() Method Duplication

**Location:**
- `app/controllers/MemberController.php` (lines 108-113)
- `app/controllers/ServerController.php` (lines 41-46)

**Duplication Pattern:**
Identical method for initializing PHPOpenfireUchatservice.

**Code:**
```php
public function getUserService() {
    $us = new PHPOpenfireUchatservice;
    $us->setEndpoint($this->rest_url);
    $us->setAuthType(PHPOpenfireUchatservice::AUTH_SHARED_KEY)->setSharedKey($this->g_rest_key);
    return $us;
}
```

**Reasoning:**
- Same initialization logic in two controllers
- Both controllers also duplicate the initialization properties (`$this->g_rest_key`, `$this->rest_url`)
- Should be in the base class or a service class

**Recommendation:**
Move to `ControllerUIBase` or create a dedicated service class.

---

## 4. Database Connection Methods Duplication

**Location:**
- `app/controllers/ServerController.php` (lines 48-62, 64-67)
- `app/controllers/LogController.php` (lines 20-34, 36-39)

**Duplication Pattern:**
Identical `connectKamailioDB()` and `executeSQL()` methods.

**Code:**
```php
public function connectKamailioDB(){
    $conn = @mysqli_connect($this->g_db_host, $this->g_db_user, $this->g_db_pass, $this->g_db_name, 3306);
    // ... identical connection logic
}

public function executeSQL($sql,$conn){
    $result = @mysqli_query($conn, $sql) or die($sql."error:".db_error($sql, $conn));
    return $result;
}
```

**Reasoning:**
- Database connection logic should be centralized
- Both controllers also duplicate the database configuration loading
- Using `@` error suppression is not ideal
- Should use Phalcon's database abstraction or a dedicated database service

**Recommendation:**
Create a database service class or move to base controller with proper error handling.

---

## 5. CURL Operations Duplication (High Priority)

**Location:**
- `app/controllers/MemberController.php` (multiple locations: lines 144-152, 185-193, 224-232, 291-299, 354-362, 405-413, 427-435, 558-566)
- `app/controllers/ServerController.php` (multiple locations: lines 73-82, 89-98, 108-117, 128-137, 949-957, 1006-1017, 1059-1074, 1097-1113)

**Duplication Pattern:**
Repeated CURL initialization, configuration, execution, and cleanup patterns.

**Example Pattern:**
```php
$s = curl_init();
curl_setopt($s, CURLOPT_HEADER, 1);
curl_setopt($s, CURLOPT_SSL_VERIFYPEER, FALSE);
curl_setopt($s, CURLOPT_URL, $url);
curl_setopt($s, CURLOPT_POST, 1);
curl_setopt($s, CURLOPT_POSTFIELDS, $params);
curl_setopt($s, CURLOPT_RETURNTRANSFER, 1);
$ret = curl_exec($s);
curl_close($s);
```

**Reasoning:**
- CURL operations appear 20+ times with slight variations
- Error handling is inconsistent (some use `@`, some don't)
- Makes code harder to maintain and test
- Should use a HTTP client service or wrapper

**Recommendation:**
Create a `HttpClientService` class with methods like `post()`, `get()`, etc. to encapsulate CURL operations.

---

## 6. IP Address Validation Duplication

**Location:**
- `app/controllers/ServerController.php` (multiple methods: `addXmppServerAction`, `editHaproxyServerAction`, `editFileServerAction`, `editSipHaproxyServerAction`, `addSipServerAction`, `addProxyServerAction`)

**Duplication Pattern:**
Repeated IP validation logic checking for 4 octets and values 0-255.

**Example:**
```php
$splits1 = explode(".", $serverIpExt);
$splits2 = explode(".", $serverIpInt);
$res = "error";
if (count($splits1) == 4 && count($splits2) == 4) {
    foreach ($splits1 as $split) {
        if (intval($split) < 0 || intval($split) > 255) {
            echo $res;exit;
        }
    }
    // ... similar for $splits2
}
```

**Reasoning:**
- IP validation logic is repeated 6+ times
- Should use PHP's `filter_var()` with `FILTER_VALIDATE_IP`
- Current validation is incomplete (doesn't handle IPv6, doesn't validate format properly)

**Recommendation:**
Create a `validateIpAddress($ip)` helper method using `filter_var()`.

---

## 7. Parameter Substring Extraction Pattern

**Location:**
- `app/controllers/LogController.php` (lines 55-60, 66-68, 115-120, 170-173, 224-227, 298-301)
- `app/controllers/MemberController.php` (lines 55-60)

**Duplication Pattern:**
Repeated pattern of extracting parameters using `substr()` with fixed offsets.

**Example:**
```php
$sentFrom = substr($sentFrom, 5, strlen($sentFrom) - 5);
$sentTo = substr($sentTo, 3, strlen($sentTo) - 3);
$id = substr($id, 3, strlen($id) - 3);
$select = substr($select, 5, strlen($select) - 5);
```

**Reasoning:**
- Magic numbers (5, 3) make code hard to understand
- Pattern suggests parameters are prefixed (e.g., "from:", "to:")
- Should use a more explicit parsing method
- Appears to be removing prefixes from URL parameters

**Recommendation:**
Create a helper method like `extractParameter($param, $prefix)` or use proper parameter parsing.

---

## 8. Delete Action Pattern Duplication

**Location:**
- `app/controllers/LogController.php` (`deleteAlertAction`, `deleteKamAlertAction`, `deleteTextLogAction`, `deleteSignAction`)
- `app/controllers/ServerController.php` (`deleteAction`, `deleteRegularAction`, `deleteMimetypeAction`)
- `app/controllers/MemberController.php` (`deleteMemberAction`)

**Duplication Pattern:**
Similar structure handling single ID or array of IDs for deletion.

**Example Pattern:**
```php
if ($this->request->hasPost("ID")){
    $no = $this->request->getPost("ID");
    $item = Model::findFirstByid($no);
    if($item){
        if ($item->delete())
            echo "success";
        else
            echo "error";
    }
    exit;
} else if($this->request->hasPost("ids")){
    $ids = $this->request->getPost("ids");
    foreach ($ids as $id) {
        $item = Model::findFirstByid($id);
        if($item)
            $item->delete();
    }
    echo "success";
    exit;
}
echo "error";
exit;
```

**Reasoning:**
- Same pattern repeated 8+ times with minor variations
- Inconsistent error handling and response format
- Should return JSON instead of echoing strings
- Logic should be abstracted

**Recommendation:**
Create a generic `deleteItems($modelClass, $idField = 'id')` method in base controller.

---

## 9. Form Class Duplication

**Location:**
- `app/forms/LoginSystemAccountForm.php`
- `app/forms/LoginSystemAccountKpForm.php`
- `app/forms/RegisterSystemAccountForm.php`
- `app/forms/RegisterSystemAccountKpForm.php`

**Duplication Pattern:**
Forms are nearly identical with only label/placeholder text differences.

**Reasoning:**
- `LoginSystemAccountForm` and `LoginSystemAccountKpForm` are 95% identical
- `RegisterSystemAccountForm` and `RegisterSystemAccountKpForm` are 90% identical
- Only differences are in labels, placeholders, and validation messages
- Should use localization/internationalization instead of separate classes

**Recommendation:**
Merge into single form classes and use language files for text differences.

---

## 10. SQL Condition Building Pattern

**Location:**
- `app/controllers/LogController.php` (multiple action methods: `signlogAction`, `textlogAction`, `xmppHistoryAction`, `sipHistoryAction`, `calllogAction`)
- `app/controllers/MemberController.php` (`summaryAction`)

**Duplication Pattern:**
Similar pattern of building SQL WHERE conditions by concatenating strings.

**Example:**
```php
$cond = "";
if ($sentFrom != "")
    $cond .= "SentTime >= '" . $sentFrom . "' AND ";
if ($sentTo != "")
    $cond .= "SentTime <= '" . $sentTo . " 23:59:59' AND ";
if ($sender != "")
    $cond .= "FromUser LIKE '%".$sender."%' AND ";
if ($cond != "")
    $cond = substr($cond, 0, strlen($cond) - 4);
```

**Reasoning:**
- String concatenation for SQL is error-prone and vulnerable to SQL injection
- Should use Phalcon's query builder
- Pattern is repeated 5+ times
- The trailing " AND " removal is fragile

**Recommendation:**
Create a `buildWhereConditions($filters)` helper method using Phalcon's query builder or parameter binding.

---

## 11. Configuration Loading Duplication

**Location:**
- `app/controllers/MemberController.php` (line 16)
- `app/controllers/ServerController.php` (line 24)
- `app/controllers/LogController.php` (line 12)

**Duplication Pattern:**
Repeated loading of config.ini file.

**Code:**
```php
$config = new ConfigIni(APP_PATH . 'app/config/config.ini');
```

**Reasoning:**
- Configuration should be loaded once and cached
- Multiple controllers load the same file
- Should use Phalcon's dependency injection or service container

**Recommendation:**
Register config as a service in `services.php` and inject it.

---

## 12. Level Detail Processing Duplication

**Location:**
- `app/controllers/MemberController.php` (lines 101-106, 254-260, 455-460)

**Duplication Pattern:**
Repeated code to fetch levels and build level set array.

**Code:**
```php
$levels = LevelDetailModel::find(["order" => "level"]);
$levelSet = [];
foreach ($levels as $level) {
    $levelSet[] = $level->level;
}
$this->view->lvSet = $levelSet;
```

**Reasoning:**
- Same logic appears 3 times in the same controller
- Should be extracted to a helper method

**Recommendation:**
Create `getLevelSet()` method in `MemberController`.

---

## 13. Date/Time Picker Asset Loading

**Location:**
- `app/controllers/MemberController.php` (line 47)
- `app/controllers/LogController.php` (lines 57, 104, 161, 285)

**Duplication Pattern:**
Repeated loading of date-time picker JavaScript.

**Code:**
```php
$this->assets->addJs("pages/scripts/components-date-time-pickers.min.js");
```

**Reasoning:**
- Same asset loaded in multiple places
- Should be included in DataTables asset loading if always used together

**Recommendation:**
Include in the `loadDataTablesAssets()` method if always used together, or create separate `loadDateTimePickerAssets()` method.

---

## 14. Server Info Retrieval Pattern

**Location:**
- `app/controllers/ServerController.php` (`getServerInfo`, `getKamServerInfo`, `getKamState`, `setKamAction`)

**Duplication Pattern:**
Similar CURL-based server info retrieval with slight variations.

**Reasoning:**
- Similar structure but different endpoints and parameters
- Could be generalized into a single method with parameters

**Recommendation:**
Create a generic `makeServerRequest($url, $data, $options)` method.

---

## Summary Statistics

- **Total Duplication Areas Identified:** 14
- **High Priority (affects maintainability significantly):** 5
- **Medium Priority (code quality improvements):** 7
- **Low Priority (minor optimizations):** 2

## Recommended Refactoring Priority

1. **Immediate:** DataTables asset loading, CURL operations, Delete action patterns
2. **Short-term:** Database connection methods, IP validation, SQL condition building
3. **Long-term:** Form class consolidation, Configuration loading, Parameter extraction

## Impact Assessment

- **Lines of Code Reduction:** ~500-800 lines could be eliminated through refactoring
- **Maintainability:** Significant improvement - changes in one place instead of many
- **Testability:** Better - centralized logic is easier to test
- **Performance:** Minimal impact, but code will be cleaner

