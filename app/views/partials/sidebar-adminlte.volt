<aside class="main-sidebar sidebar-dark-primary elevation-4">
    <!-- Brand Logo -->
    <a href="{{ url('server/index') }}" class="brand-link">
      <img src="{{ url('login/logo.svg') }}" alt="Logo" class="brand-image img-circle elevation-3" style="opacity: .8">
      <span class="brand-text font-weight-light">CMM Admin</span>
    </a>

    <!-- Sidebar -->
    <div class="sidebar d-flex flex-column">
      <!-- Sidebar user panel (optional) -->
      <div class="user-panel mt-3 pb-3 mb-3 d-flex">
        <div class="image">
          <img src="{{ url('adminlte/dist/img/avatar.png') }}" class="img-circle elevation-2" alt="User Image">
        </div>
        <div class="info">
          <a href="#" class="d-block" data-toggle="dropdown" aria-expanded="false" role="button" aria-haspopup="true" aria-label="User menu">{{ authAdmin['name'] }}</a>
          <div class="dropdown-menu dropdown-menu-lg dropdown-menu-left">
            <span class="dropdown-item dropdown-header">{{ authAdmin['name'] }}</span>
            <div class="dropdown-divider"></div>
            <a href="#" class="dropdown-item">
              <i class="fas fa-user mr-2"></i> {{ lang._('menu_profile') }}
            </a>
            <div class="dropdown-divider"></div>
            <a href="{{ url('session/end') }}" class="dropdown-item">
              <i class="fas fa-sign-out-alt mr-2"></i> {{ lang._('menu_logout') }}
            </a>
          </div>
        </div>
      </div>

      <!-- Sidebar Menu -->
      <nav class="mt-2 flex-grow-1">
        <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
          
          <!-- Dashboard -->
          <?php if (in_array("dashboard/index", $acceptAcl)){ ?>
          <li class="nav-item">
            <a href="{{ url('dashboard/index') }}" class="nav-link">
              <i class="nav-icon fas fa-tachometer-alt"></i>
              <p>{{ lang._('menu_dashboard') }}</p>
            </a>
          </li>
          <?php } ?>

          <!-- Server Manager -->
          <?php if (in_array("server/index", $acceptAcl) || in_array("server/serversetting", $acceptAcl) || in_array("server/xmppserver", $acceptAcl) || in_array("server/sipserver", $acceptAcl) || in_array("server/proxyserver", $acceptAcl)){ ?>
          <li class="nav-item">
            <a href="#" class="nav-link" id="menu-server">
              <i class="nav-icon fas fa-server"></i>
              <p>
                {{ lang._('menu_servermanager') }}
                <i class="fas fa-angle-left right"></i>
              </p>
            </a>
            <ul class="nav nav-treeview">
              <?php if (in_array("server/index", $acceptAcl)){ ?>
              <li class="nav-item">
                <a href="{{ url('server/index') }}" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>{{ lang._('menu_server_list') }}</p>
                </a>
              </li>
              <?php } ?>
              
              <?php if (in_array("server/serversetting", $acceptAcl)){ ?>
              <li class="nav-item">
                <a href="{{ url('server/serversetting') }}" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>{{ lang._('menu_server_setting') }}</p>
                </a>
              </li>
              <?php } ?>
              
              <?php if (in_array("server/xmppserver", $acceptAcl)){ ?>
              <li class="nav-item">
                <a href="{{ url('server/xmppserver') }}" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>{{ lang._('menu_xmpp_server') }}</p>
                </a>
              </li>
              <?php } ?>
              
              <?php if (in_array("server/sipserver", $acceptAcl)){ ?>
              <li class="nav-item">
                <a href="{{ url('server/sipserver') }}" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>{{ lang._('menu_sip_server') }}</p>
                </a>
              </li>
              <?php } ?>
              
              <?php if (in_array("server/proxyserver", $acceptAcl)){ ?>
              <li class="nav-item">
                <a href="{{ url('server/proxyserver') }}" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>{{ lang._('menu_proxy_server') }}</p>
                </a>
              </li>
              <?php } ?>
            </ul>
          </li>
          <?php } ?>

          <!-- Member Management -->
          <?php if (in_array("member/register", $acceptAcl) || in_array("member/summary", $acceptAcl) || in_array("member/setlevel", $acceptAcl) || in_array("member/levelList", $acceptAcl)){ ?>
          <li class="nav-item">
            <a href="#" class="nav-link" id="menu-member">
              <i class="nav-icon fas fa-users"></i>
              <p>
                {{ lang._('menu_registration') }}
                <i class="fas fa-angle-left right"></i>
              </p>
            </a>
            <ul class="nav nav-treeview">
              <?php if (in_array("member/summary", $acceptAcl)){ ?>
              <li class="nav-item">
                <a href="{{ url('member/summary') }}" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>{{ lang._('menu_member_summary') }}</p>
                </a>
              </li>
              <?php } ?>
              
              <?php if (in_array("member/register", $acceptAcl)){ ?>
              <li class="nav-item">
                <a href="{{ url('member/register') }}" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>{{ lang._('menu_member_register') }}</p>
                </a>
              </li>
              <?php } ?>
              
              <?php if (in_array("member/setlevel", $acceptAcl)){ ?>
              <li class="nav-item">
                <a href="{{ url('member/setlevel') }}" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>{{ lang._('menu_member_level') }}</p>
                </a>
              </li>
              <?php } ?>
              
              <?php if (in_array("member/levelList", $acceptAcl)){ ?>
              <li class="nav-item">
                <a href="{{ url('member/levelList') }}" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>{{ lang._('menu_level_list') }}</p>
                </a>
              </li>
              <?php } ?>
            </ul>
          </li>
          <?php } ?>

          <!-- Logs -->
          <?php if (in_array("log/calllog", $acceptAcl) || in_array("log/textlog", $acceptAcl) || in_array("log/signlog", $acceptAcl) || in_array("log/xmppHistory", $acceptAcl) || in_array("log/sipHistory", $acceptAcl)){ ?>
          <li class="nav-item">
            <a href="#" class="nav-link" id="menu-log">
              <i class="nav-icon fas fa-history"></i>
              <p>
                {{ lang._('menu_log') }}
                <i class="fas fa-angle-left right"></i>
              </p>
            </a>
            <ul class="nav nav-treeview">
              <?php if (in_array("log/calllog", $acceptAcl)){ ?>
              <li class="nav-item">
                <a href="{{ url('log/calllog') }}" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>{{ lang._('menu_call_log') }}</p>
                </a>
              </li>
              <?php } ?>
              
              <?php if (in_array("log/textlog", $acceptAcl)){ ?>
              <li class="nav-item">
                <a href="{{ url('log/textlog') }}" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>{{ lang._('menu_text_log') }}</p>
                </a>
              </li>
              <?php } ?>
              
              <?php if (in_array("log/signlog", $acceptAcl)){ ?>
              <li class="nav-item">
                <a href="{{ url('log/signlog') }}" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>{{ lang._('menu_sign_log') }}</p>
                </a>
              </li>
              <?php } ?>
              
              <?php if (in_array("log/xmppHistory", $acceptAcl)){ ?>
              <li class="nav-item">
                <a href="{{ url('log/xmppHistory') }}" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>{{ lang._('menu_xmpp_history') }}</p>
                </a>
              </li>
              <?php } ?>
              
              <?php if (in_array("log/sipHistory", $acceptAcl)){ ?>
              <li class="nav-item">
                <a href="{{ url('log/sipHistory') }}" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>{{ lang._('menu_sip_history') }}</p>
                </a>
              </li>
              <?php } ?>
            </ul>
          </li>
          <?php } ?>

        </ul>
      </nav>
      <!-- /.sidebar-menu -->
      
      <!-- Sidebar Footer -->
      <div class="sidebar-footer mt-auto pb-3">
        <div class="d-flex justify-content-center">
          <a class="btn btn-sm btn-link text-white" href="#" data-widget="fullscreen" role="button" title="Toggle Fullscreen" aria-label="Toggle Fullscreen">
            <i class="fas fa-expand-arrows-alt"></i>
          </a>
        </div>
      </div>
    </div>
    <!-- /.sidebar -->
  </aside>

