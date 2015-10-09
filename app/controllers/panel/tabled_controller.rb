class Panel::TabledController < AdminController

  respond_to :html, :json, :csv
  before_filter :init_breadcrumb

  def init_breadcrumb
    add_breadcrumb I18n.t("layouts.panel.breadcrumb.home"), panel_root_url
  end

  def conditions conditions = {}
    conditions
  end

  def namespace
    :panel
  end
  helper_method :namespace

  def model
    raise NoTypeGivenError
  end
  helper_method :model

  def index_url
    url_for action: :index
  end
  helper_method :index_url

  def csv_url
    url_for action: :index, format: :csv
  end
  helper_method :csv_url

  def item_url id
    url_for action: :show, id: id
  end
  helper_method :item_url

  def edit_item_url id
    url_for action: :edit, id: id
  end
  helper_method :edit_item_url

  def new_item_url
    url_for action: :new
  end
  helper_method :new_item_url

  def unban_item_url id
    url_for action: :unban, id: id
  end
  helper_method :unban_item_url

  def ban_item_url id
    url_for action: :ban, id: id
  end
  helper_method :ban_item_url

  def table_headers
    []
  end
  helper_method :table_headers

  def searched_fields
    []
  end
  helper_method :searched_fields

  def quick_search q
    searched_fields.present? ? { [searched_fields.join('_or_'), 'cont'].join('_') => q } : q
  end
  helper_method :quick_search

  def init_form
  end

  def index
    @items = model.accessible_by(current_ability).where(conditions)
    authorize! :read, model

    add_breadcrumb t("activerecord.models.#{model.to_s.underscore}").pluralize(I18n.locale), index_url
    respond_to do |format|
      format.csv { send_data @items.to_csv(current_ability) }
      format.all { respond_with @items }
    end

  end

  def show
    @item = model.find params[:id]
    authorize! :read, @item

    add_breadcrumb t("activerecord.models.#{model.to_s.underscore}").pluralize(I18n.locale), index_url
    add_breadcrumb t("layouts.panel.breadcrumb.show")
  end

  def new
    @item = model.new
    authorize! :create, @item

    init_form
    add_breadcrumb t("activerecord.models.#{model.to_s.underscore}").pluralize(I18n.locale), index_url
    add_breadcrumb t("layouts.panel.breadcrumb.new")
  end

  def create
    @item = model.new item_params
    authorize! :create, @item

    if @item.save
      redirect_to url_for(action: :edit, id: @item.id), notice: t('layouts.panel.notice.created')
    else
      init_form
      add_breadcrumb t("activerecord.models.#{model.to_s.underscore}").pluralize(I18n.locale), index_url
      add_breadcrumb t("layouts.panel.breadcrumb.new")
      render action: :new
    end
  end

  def edit
    @item = model.find params[:id]
    authorize! :read, @item

    init_form
    add_breadcrumb t("activerecord.models.#{model.to_s.underscore}").pluralize(I18n.locale), index_url
    add_breadcrumb t("layouts.panel.breadcrumb.edit")
  end

  def update
    @item = model.find params[:id]
    authorize! :update, @item

    if @item.update_attributes item_params
      redirect_to url_for(action: :edit, id: @item.id), notice: t('layouts.panel.notice.updated')
    else
      init_form
      add_breadcrumb t("activerecord.models.#{model.to_s.underscore}").pluralize(I18n.locale), index_url
      add_breadcrumb t("layouts.panel.breadcrumb.edit")
      render action: :edit
    end
  end

  def destroy
    @item = model.find params[:id]
    authorize! :destroy, @item

    @item.destroy
    redirect_to url_for(action: :index), notice: t('layouts.panel.notice.deleted')
  end

  # Permission helper method, view permissions rake task
  #
  # Returns array
  def permission
    [model, I18n.t("activerecord.controllers.#{model.to_s.pluralize.underscore}").capitalize]
  end
  helper_method :permission
end
