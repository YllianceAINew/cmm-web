<?php
/**
 * QUICK START EXAMPLES - How to Use AdminLTE in Your Controllers
 * 
 * Copy these code snippets into your existing controllers to enable AdminLTE
 */

// ==========================================
// EXAMPLE 1: Dashboard Controller
// ==========================================

// File: app/controllers/DashboardController.php
// Add this at the beginning of indexAction() method

public function indexAction()
{
    // *** ADD THESE TWO LINES TO USE ADMINLTE ***
    $this->view->setLayout('adminlte');
    $this->view->pick('dashboard/index-adminlte');
    
    // Update assets to use AdminLTE plugins instead of old ones
    // Replace old DataTables with AdminLTE version
    $this->assets->addCss("adminlte/plugins/datatables-bs4/css/dataTables.bootstrap4.min.css");
    $this->assets->addJs("adminlte/plugins/datatables/jquery.dataTables.min.js");
    $this->assets->addJs("adminlte/plugins/datatables-bs4/js/dataTables.bootstrap4.min.js");
    
    // Use AdminLTE Flot plugin for charts
    $this->assets->addJs("adminlte/plugins/flot/jquery.flot.min.js");
    $this->assets->addJs("adminlte/plugins/flot/jquery.flot.resize.min.js");
    $this->assets->addJs("adminlte/plugins/flot/jquery.flot.categories.min.js");
    
    // Add custom dashboard script
    $this->assets->addJs("adminlte/custom/dashboard-adminlte.js");
    
    // *** KEEP ALL YOUR EXISTING CODE BELOW ***
    $members = UserMemberModel::find();
    $this->view->members = $members;
    
    // ... rest of your existing code ...
}


// ==========================================
// EXAMPLE 2: Session Controller (Login Page)
// ==========================================

// File: app/controllers/SessionController.php
// Add this at the beginning of indexAction() method

public function indexAction()
{
    // *** ADD THESE TWO LINES TO USE ADMINLTE LOGIN ***
    $this->view->setLayout('login-adminlte');
    $this->view->pick('session/index-adminlte');
    
    // *** KEEP ALL YOUR EXISTING CODE BELOW ***
    $this->view->cleanTemplateAfter();
    $this->session->remove('authAdmin');
    $this->session->destroy();
    
    if (isset($_SERVER['SSL_CLIENT_S_DN_CN'])) {
        $this->view->caFlag = 1;
        $this->view->userId = $_SERVER['SSL_CLIENT_S_DN_CN'];
    } else {
        $this->view->caFlag = 0;
    }
    
    $this->view->form = new LoginSystemAccountKpForm;
}


// ==========================================
// EXAMPLE 3: Any Other Controller
// ==========================================

// For Server, Member, Log, or other controllers
// Add this to any action method:

public function anyAction()
{
    // *** ADD THIS LINE TO USE ADMINLTE ***
    $this->view->setLayout('adminlte');
    
    // Optional: if you created a new AdminLTE view file
    // $this->view->pick('controllername/viewname-adminlte');
    
    // Add any required AdminLTE plugins
    $this->assets->addCss("adminlte/plugins/datatables-bs4/css/dataTables.bootstrap4.min.css");
    $this->assets->addJs("adminlte/plugins/datatables/jquery.dataTables.min.js");
    $this->assets->addJs("adminlte/plugins/datatables-bs4/js/dataTables.bootstrap4.min.js");
    
    // *** KEEP ALL YOUR EXISTING CODE BELOW ***
    // ... your existing code ...
}


// ==========================================
// EXAMPLE 4: Global Change (All Controllers)
// ==========================================

// File: app/controllers/ControllerUIBase.php
// Modify the initialize() method to set AdminLTE as default layout

protected function initialize()
{
    $this->tag->prependTitle($this->lang['site_title'].'| ');
    
    // *** ADD THIS LINE TO USE ADMINLTE GLOBALLY ***
    $this->view->setLayout('adminlte');
    
    // Add some local CSS resources
    $this->view->lang = $this->lang;

    $auth = $this->session->get("authAdmin");
    if ($auth) {
        $this->view->authAdmin = $auth;
        if ($auth['acl'] == 'ALL')
            $this->view->acceptAcl = array("dashboard/index", 
                            "server/index", "server/serversetting", "server/xmppserver", "server/sipserver", "server/proxyserver", "server/irregular", "server/mimetype",
                            "log/calllog", "log/textlog", "log/signlog", "log/xmppHistory","log/sipHistory", 
                            "member/register", "member/summary", "member/setlevel", "member/levelList");
        else
            $this->view->acceptAcl = json_decode($auth['acl']);
    }
}


// ==========================================
// NOTES:
// ==========================================

/*
 * 1. TWO WAYS TO APPLY ADMINLTE:
 *    - Per Controller: Add setLayout() in each controller action
 *    - Globally: Add setLayout() in ControllerUIBase::initialize()
 * 
 * 2. KEEP OLD FILES:
 *    - Your original views are preserved (e.g., dashboard/index.volt)
 *    - New AdminLTE views have -adminlte suffix (e.g., dashboard/index-adminlte.volt)
 *    - You can switch back anytime by removing setLayout() and pick() calls
 * 
 * 3. ASSET REPLACEMENT:
 *    - Old: global/plugins/datatables/datatables.js
 *    - New: adminlte/plugins/datatables/jquery.dataTables.min.js
 * 
 * 4. TESTING WORKFLOW:
 *    - Test one page at a time
 *    - Start with Dashboard
 *    - Then Login
 *    - Then other pages
 * 
 * 5. IF SOMETHING BREAKS:
 *    - Check browser console for JavaScript errors
 *    - Verify all assets are loading (check Network tab)
 *    - Make sure jQuery loads before other scripts
 *    - Clear cache: delete files in cache/volt/ folder
 */

