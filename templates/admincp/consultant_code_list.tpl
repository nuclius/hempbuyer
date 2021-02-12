<!-- ===================== start change by divyesh (added) ===================== -->
{include file="/admincp/header.tpl" nocache}

<div class="container-fluid">

    <div class="row">
        <div class="col-lg-12" style="margin-top:2%;">

            <ol class="breadcrumb">
                <li class="active" style=" text-transform: capitalize;">
                    {$action} Generated
                    Code List
                </li>
            </ol>
        </div>
    </div>


    <form action="{$config.url}/{$loged.adminUrl}/consultant_code/search" method="get">
        <div class="row">
            <div class="col-lg-12">
                <div class="col-lg-3">
                    <div class="form-group">
                        <input type="text" value="{$name}" name="name" placeholder="name">
                    </div>
                </div>

                <div class="col-lg-3">
                    <div class="form-group">
                        <input type="text" value="{$email}" name="email" placeholder="email">
                    </div>
                </div>

                <div class="col-lg-3">
                    <div class="form-group">
                        <input type="text" value="{$sc_code}" name="sc_code"
                            placeholder="consultant code">
                    </div>
                </div>
                <div class="col-lg-3">
                    <div class="form-group ">
                        <input class="btn  btn-success" type="submit" value="Search" />
                    </div>
                </div>
            </div>
        </div>
    </form>
    <div class="table-responsive">
        <table class="table table-bordered table-hover" id="consultantcodeList">
            <thead>
                <tr>
                    <th>Name</th>
                    <th>Email Address</th>
                    <th>Code</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                {foreach $consultantCode as $key => $val}
                {$usercount = 1}
                <tr>

                    <td>{$val.name}</td>
                    <td>{$val.email}</td>
                    <td>{$val.sc_code}</td>
                    <td>
                        <a onclick="return confirm('Are you sure to delete code for user:{$val.email}');"
                            href="{$config.url}/{$loged.adminUrl}/consultant_code/delete/{$val.email}">Delete</a>

                        <a onclick="" href="{$config.url}/{$loged.adminUrl}/consultant_code/edit/{$val.id}">Edit</a>
                    </td>

                </tr>
                {/foreach}
                {if $consultantCodeCount == 0}
                <tr>
                    <td colspan="4">
                        No Consultant Code Found !
                    </td>
                </tr>
                {/if}
            </tbody>
        </table>
    </div>
</div>
{include file="/admincp/footer.tpl" nocache}
<!-- ===================== end change by divyesh (added) ===================== -->