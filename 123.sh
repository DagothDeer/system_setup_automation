#!/bin/bash

# Набор цветов для покраски шрифтов в консоли
  RESET='\033[0m'
  BLACK='\033[0;30m'
  WHITE='\033[0;37m'
    RED='\033[0;31m'
 YELLOW='\033[0;33m'
  GREEN='\033[0;32m'
   CYAN='\033[0;36m'
   BLUE='\033[0;34m'
MAGENTA='\033[0;35m'

#FUNC Функция изменения адреса шлюза поумолчанию
change_gateway_address() {
    echo ""
}

#FUNC Функция изменения широковещательного адреса
change_broadcast_address() {
    echo ""
}

#FUNC Функция изменения адреса подсети
change_network_address() {
    echo ""
}

#FUNC Функция изменения маски подсети
change_network_mask() {
    echo ""
}

#FUNC Функция изменения IP адреса
change_IP_address() {
    echo ""
}

#FUNC Функция смены настройки сетевой карты на динамическую
switch_to_dynamic_IP() {
    echo ""
}

#FUNC Функция запуска мастера конфигурации сети
run_network_configuration_wizard() {
    change_IP_address           #^ Вызов функции изменения IP адреса
    change_network_mask         #^ Вызов функции изменения маски подсети
    change_network_address      #^ Вызов функции изменения адреса подсети
    change_broadcast_address    #^ Вызов функции изменения широковещательного адреса
    change_gateway_address      #^ Вызов функции изменения адреса шлюза поумолчанию
}

#FUNC функция выбора элемента из меню редактирования конфига со статическим IP
select_element_of_menu_edit_static_IP() {
    while (( 1 )); do

        case "${choise}" in
            "1"|"1."|"1. Switch to DYNAMIC IP configuration"|"Switch to DYNAMIC IP configuration")
                switch_to_dynamic_IP #^ Вызов функции смены настройки сетевой карты на динамическую
            ;;
            "2"|"2."|"2. Run network configuration wizard"|"Run network configuration wizard")
                run_network_configuration_wizard #^ Вызов функции запуска мастера конфигурации сети
            ;;
            "3"|"3."|"3. Change IP address"|"Change IP address")
                change_IP_address #^ Вызов функции изменения IP адреса
            ;;
            "4"|"4."|"4. Change network mask"|"Change network mask")
                change_network_mask #^ Вызов функции изменения маски подсети
            ;;
            "5"|"5."|"5. Change network address"|"Change network address")
                change_network_address #^ Вызов функции изменения адреса подсети
            ;;
            "6"|"6."|"6. Change broadcast address"|"Change broadcast address")
                change_broadcast_address #^ Вызов функции изменения широковещательного адреса
            ;;
            "7"|"7."|"7. Change gateway address"|"Change gateway address")
                change_gateway_address #^ Вызов функции изменения адреса шлюза поумолчанию
            ;;
            "9"|"9. Back"|"9."|"Back"|"back")
                show_network_card_menu #^ Вызов функции вывода меню выбора сетевых карт
                select_element_of_network_card_menu #^ Вызов функции обработки элементов меню выбора сетевой карты
		    ;;
            *)
                echo -e "${YELLOW}WARNING!${RESET} Input ${GREEN}yes${RESET} or ${RED}no${RESET}! (like y,yes,n,no etc...)"
                continue
            ;;
        esac

        break
    done
}

#FUNC функция вывода меню редактирования конфига со статическим IP
show_menu_edit_static_IP_config() {
    echo 'Select of available item:'
	echo -e "  ${CYAN}1. Switch to ${GREEN}DYNAMIC${CYAN} IP configuration"
	echo -e "  2. Run network configuration wizard"
    echo -e "  3. Change IP address"
	echo -e "  4. Change network mask"
    echo -e "  5. Change network address"
    echo -e "  6. Change broadcast address"
    echo -e "  7. Change gateway address"
    echo -e "  ..."
    echo -e "  ${RED}9. Back${RESET}"
	
	echo -en "Your choise: ${MAGENTA}"
	read -r choise
	echo -e "${RESET}"

    select_element_of_menu_edit_static_IP #^ Вызов функции выбора элемента из меню редактирования конфига со статическим IP
}

#FUNC Функция выбора элемента из меню редактирования конфига с динамическим IP
select_element_of_menu_edit_dynamic_IP() {
    while (( 1 )); do

        case "${choise}" in
            "1"|"1."|"1. Switch to STATIC IP configuration"|"Switch to STATIC IP configuration")
                echo -e "${GREEN}Network configuration wizard running...${RESET}"
                run_network_configuration_wizard #^ Вызов функции запуска мастера конфигурации сети
            ;;
            "9"|"9. Back"|"9."|"Back"|"back")
                show_network_card_menu #^ Вызов функции вывода меню выбора сетевых карт
                select_element_of_network_card_menu #^ Вызов функции обработки элементов меню выбора сетевой карты
		    ;;
            *)
                echo -e "${YELLOW}WARNING!${RESET} Input ${GREEN}yes${RESET} or ${RED}no${RESET}! (like y,yes,n,no etc...)"
                continue
            ;;
        esac

        break
    done
}

#FUNC функция вывода меню редактирования конфига с динамическим IP
show_menu_edit_dynamic_IP_config() {
    echo 'Select of available item:'
	echo -e "  ${CYAN}1. Switch to ${GREEN}STATIC IP ${CYAN}configuration"
    echo -e "  ${RED}9. Back${RESET}"
	
	echo -en "Your choise: ${MAGENTA}"
	read -r choise
	echo -e "${RESET}"

    select_element_of_menu_edit_dynamic_IP #^ Вызов Функции выбора элемента из меню редактирования конфига с динамическим IP
}

#FUNC Функция обработки элементов меню выбора сетевой карты
select_element_of_network_card_menu() {
    while (( 1 )); do

        echo -e "Do You want to edit this network card settings? (${GREEN}y${RESET}/${RED}n${RESET})"
        echo -en "${MAGENTA}"
        read -r user_answer
        echo -en "${RESET}"
        echo

        case "${user_answer}" in
            "y"|"Y"|"yes"|"YES"|"Yes"|"Ye"|"Da"|"+"|"1")

                type_of_IP=$(< /etc/network/interfaces_2 grep -E "iface ${selected_network_card} inet " | awk '{print $4}')

                if [[ "${type_of_IP}" == "dynamic" ]]; then
                    show_menu_edit_dynamic_IP_config #^ Вызов функции вывода меню редактирования конфига с динамическим IP
                else
                    show_menu_edit_static_IP_config #^ Вызов функции вывода меню редактирования конфига со статическим IP
                fi
            ;;
            "n"|"N"|"no"|"NO"|"No"|"Ne"|"Net"|"-"|"0")
				show_network_card_menu #^ Вызов функции вывода меню выбора сетевых карт
                select_element_of_network_card_menu #^ Вызов функции обработки элементов меню выбора сетевой карты
            ;;
            *)
                echo -e "${YELLOW}WARNING!${RESET} Input ${GREEN}yes${RESET} or ${RED}no${RESET}! (like y,yes,n,no etc...)"
                continue
            ;;
        esac

        break
    done
}

#FUNC Функция вывода меню выбора сетевых карт 
show_network_card_menu() {
    #! Путь не правильный
	path_to_network_config=/etc/network/interfaces_2
    list_of_all_network_cards=$(< ${path_to_network_config} grep -E "iface" | awk '{print $2}')
    number_of_all_network_cards=$(echo "{$list_of_all_network_cards}" | wc -l)
    
    #! Костыль!!! Создаем временный файл.
    echo "${list_of_all_network_cards}" | tail -$(( "${number_of_all_network_cards}"-1 )) > ~/script/tmp
    
    array_of_editing_network_cards=()
    while read -r line; do
        array_of_editing_network_cards+=("$line")
    done < ~/script/tmp

    #! Костыль!!! Удаляем временный файл.
    rm ~/script/tmp

    echo "======= AVAILABLE NETWORK CARDS ======="
        echo -en "${CYAN}"
		for ((i=0;i<"${#array_of_editing_network_cards[@]}";i++)); do
			echo "  $(("${i}"+1)). ${array_of_editing_network_cards[i]}"
		done
        echo -en "${RESET}"
        number_of_back_item=$(("${i}"+1))
        echo -e "  ${RED}${number_of_back_item}. Back${RESET}"
    echo "======================================="
    echo

    selected_network_card_number=0

    while (( 1 )); do
        echo -en "Select a network card to view its settings or change the configuration: ${MAGENTA}"
        read -r selected_network_card_number
        echo -ne "${RESET}"
        # Если введенный номер соответствует номерам сетевых карт
        if [[ "${selected_network_card_number}" -gt 0 ]] && [[ "${selected_network_card_number}" -le "${#array_of_editing_network_cards[@]}" ]]; then
            break
        # Если введенный номер соответствует пункту меню Back
        elif [[ "${selected_network_card_number}" -eq "${number_of_back_item}" ]]; then
            break
        # Если введенный номер не соответствует ничему
        else
            echo -e "${YELLOW}You should enter the number from list above only!${RESET}"
            echo
        fi
    done

    # Если введенный номер соответствует пункту меню Back
    if [[ "${selected_network_card_number}" -eq "${number_of_back_item}" ]]; then
        show_netwok_setup_menu #^ Вызов функции вывода меню настройки сети
    fi

    selected_network_card="${array_of_editing_network_cards[$(( "${selected_network_card_number}"-1 ))]}"
    echo -e "  Current configuration of ${CYAN}\"${selected_network_card}\"${RESET} network card:"
    
	echo "  ---------------------------------------"
		
		# Ищем строку начала блока с описанием выбранной сетевой карты
		#? "grep -n" - поиск с выводом номеров строк
		#? "cut -d:" - при разрезании строки с помощью cut в качестве разделителя (delimiter) используем ":"
		#? "cut -f1" - после разрезки выводим только первый столбик
		first_string_number=$(( "$(grep -n "${selected_network_card}" "${path_to_network_config}" | cut -d: -f1 | head -1)" - 1 ))
		# echo "first_string_number=${first_string_number}"
	
		line_number=1
	
		# Перебираем и выводим строки файла "/etc/network/interfaces", начиная со строки с началом блока описания выбранной сетевой карты и до первой пустой строки
		while read -r line; do
			if [[ "${line_number}" -lt "${first_string_number}" ]]; then
				line_number="$(( "${line_number}"+1 ))"
				continue
			else
				line_number="$(( "${line_number}"+1 ))"
			fi
	
			# Ключ "! -n" или "-z" - тест для empty string (return TRUE if empty)
			if [[ -z "${line}" ]]; then
				break
			# Если строка содержит данные
			else
				# Выводим пользователю строки с настройкой выбранной сетевой карты
				echo -e "    ${CYAN}${line}${RESET}"
	
				array_of_previous_card_config+=("${line}")
			fi
		done < ${path_to_network_config}
	
    echo "  ---------------------------------------" 
}

#FUNC Функция вывода меню настройки сети
show_netwok_setup_menu() {
    echo 'Select item:'
	echo -e "  ${CYAN}1. Network cards"
	echo -e "  2. Disable IPv6"
	echo -e "  3. Test ping"
	echo -e "  ...${RESET}"
    echo -e "  ${RED}9. Back${RESET}"
	
	echo -en "Your choise: ${MAGENTA}"
	read -r choise
	echo -e "${RESET}"
	
	while (( 1 )); do
	
		case "${choise}" in
		"1"|"1. Network cards"|"1."|"Network cards")
			echo -e "${YELLOW}Getting list of network cards...${RESET}"
			show_network_card_menu #^ Вызов функции вывода меню выбора сетевых карт
            select_element_of_network_card_menu #^ Вызов функции обработки элементов меню выбора сетевой карты
		;;
        "2"|"2. Disable IPv6"|"2."|"Disable IPv6")
			echo -e "${YELLOW}Disabling IPv6...${RESET}"
            echo -e "..."
            echo -e "..."
            echo -e "..."
            show_netwok_setup_menu #^ Вызов функции вывода меню настройки сети
		;;
        "3"|"3. Test ping"|"3."|"Test ping")
			echo -e "${YELLOW}Testing ping...${RESET}"
            #? ping -c 4 -q google.com
            #? if (( "echo $?" == 0 )) -> все пакеты успешно дошли
            #? if (( "echo $?" == 1 )) -> пингуемый IP адрес / домен не доступен
            #? if (( "echo $?" == 2 )) -> не существующий пингуемый IP адрес / домен
            echo -e "..."
            echo -e "..."
            echo -e "..."
            show_netwok_setup_menu #^ Вызов функции вывода меню настройки сети
		;;
        "9"|"9. Back"|"9."|"Back"|"back")
            show_setup_menu #^ Вызов функции вывода меню выбора настраевомого компонента
		;;
		*)
			echo -e "${YELLOW}WARNING!${RESET} You should choise next action from list above!"
			echo
		    
            echo -en "Your choise: ${MAGENTA}"
			read -r choise
			continue
		;;
		esac
	
		break
	done
}

#FUNC Функция мастера настройки сети
run_network_setup() {
    show_netwok_setup_menu #^ Вызов функции вывода меню настройки сети
}

#FUNC Функция вывода меню выбора настраевомого компонента
show_setup_menu() {
    echo 'Select configuring component:'
	echo -e "  ${CYAN}1. Network"
	echo -e "  ...${RESET}"
    echo -e "  ${RED}9. Back${RESET}"
	
	echo -en "Your choise: ${MAGENTA}"
	read -r choise
	echo -e "${RESET}"
	
	while (( 1 )); do
	
		case "${choise}" in
		"1"|"1. Network"|"1."|"Network")
			echo -e "${YELLOW}Getting list of network cards...${RESET}"
			run_network_setup #^ Вызов функции мастера настройки сети
		;;
        "9"|"9. Back"|"9."|"Back"|"back")
            show_main_menu #^ Вызов функции вывода главного меню
		;;
		*)
			echo -e "${YELLOW}WARNING!${RESET} You should choise next action from list above!"
			echo
		    
            echo -en "Your choise: ${MAGENTA}"
			read -r choise
			continueы
		;;
		esac
	
		break
	done
}

#FUNC Функция мастера настройки системы
run_setup_master() {
    show_setup_menu #^ Вызов функции вывода меню выбора настраевомого компонента
}

#FUNC Функция получения информации о MEMORY
get_MEMORY_INFO() {
	echo -e "${YELLOW} * MEMORY:${RESET}"
    echo -e "${YELLOW}    Free Ram:${RESET}"
    echo -n "     "
    free -ht | grep -E "total"
    echo -n "     "
    free -ht | grep -E "Mem:"
    echo -n "     "
    free -ht | grep -E "Swap:"
    echo -n "     "
    free -ht | grep -E "Total:"
}

#FUNC Функция получения информации о DISK
get_DISK_INFO() {
	echo -e "${YELLOW} * DISK:${RESET}"
    echo -e "${YELLOW}    Free space:${RESET}"
    echo -n "     "
    df -hT | grep -E "Filesystem"
    echo -n "     "
    df -hT | grep -E "/dev/sd"

    echo -e "${YELLOW}    Free inodes:${RESET}"
    echo -n "     "
    df -hTi | grep -E "Filesystem"
    echo -n "     "
    df -hTi | grep -E "/dev/sd"
}

#FUNC Функция получения информации о CPU
get_CPU_INFO() { 
    echo -e "${YELLOW} * CPU:${RESET}"

    < /proc/cpuinfo grep -E "model name" | head -1 | (sed -r "s/model name\t: /   - Model name: /" || true)
    echo "   - Cores number: $(nproc)"

    local load_average
    load_average="$(uptime | awk -F 'load average: ' '{print $2}')"
    echo "   - Load Average: ${load_average}"
    # Альтернативный вариант
    # one_minute="$(uptime | awk '{print $9}')"
    # five_minutes="$(uptime | awk '{print $10}')"
    # fifteen_minutes="$(uptime | awk '{print $11}')"
    # echo "* CPU:"
    # echo "Load Average2: ${one_minute} ${five_minutes} ${fifteen_minutes}"
}

#FUNC Функция получения информации об ОС
get_OS_INFO() { 
    echo -e "${YELLOW} * OS:${RESET}"

    oc_type=$(hostnamectl | grep -E 'Operating System: ' | (sed -r "s/  Operating System: //") || true)
    kernel=$(hostnamectl | grep -E 'Kernel: ' | (sed -r "s/            Kernel: //") || true)

    echo -e "   - Distribution: ${oc_type}"
    echo -e "   - Kernel version: ${kernel}"
}

#FUNC Функция получения информации о SYSTEM
get_SYSTEM_INFO() {
    get_OS_INFO     #^ Вызов функции получения информации об ОС
	get_CPU_INFO	#^ Вызов функции получения информации о CPU
    get_DISK_INFO	#^ Вызов функции получения информации о DISK
	get_MEMORY_INFO	#^ Вызов функции получения информации о MEMORY
	
	while (( 1 )); do

        echo
        echo -e "Do You want back to main menu? (${GREEN}y${RESET}/${RED}n${RESET})"
        echo -en "${MAGENTA}"
        read -r user_answer
        echo -en "${RESET}"

        case "${user_answer}" in
            "y"|"Y"|"yes"|"YES"|"Yes"|"Ye"|"Da"|"+"|"1")
                show_main_menu #^ Вызов функции вывода главного меню
            ;;
            "n"|"N"|"no"|"NO"|"No"|"Ne"|"Net"|"-"|"0")
				echo "Ok"
                # Если пользователь пока не хочет выъодить, то заного выводим ему информацию и задаем вопрос о желании выйти,
                # чтобы избежать постоянного чата "хотите выйти? нет"
                get_SYSTEM_INFO #^ Вызов функции получения информации о системе
            ;;
            *)
                echo -e "${YELLOW}WARNING!${RESET} Input ${GREEN}yes${RESET} or ${RED}no${RESET}! (like y,yes,n,no etc...)"
                continue
            ;;
        esac
        break
    done
}

#FUNC Функция вывода главного меню
show_main_menu() {
	echo 'Select next action:'
	echo -e "  ${CYAN}1. Get system INFO"
	echo -e "  2. Basic system setup"
	echo -e "  ...${RESET}"
    echo -e "  ${RED}9. Exit${RESET}"
	
	echo -en "Your action: ${MAGENTA}"
	read -r next_action
	echo -e "${RESET}"
	
	while (( 1 )); do
	
		case "${next_action}" in
		"1"|"1. Get system INFO"|"1."|"Get system INFO")
			echo -e "${GREEN}Geting system INFO...${RESET}"
			get_SYSTEM_INFO #^ Вызов функции получения информации о системе
		;;
		"2"|"2. Basic system setup"|"2."|"Basic system setup")
			echo -e "${GREEN}Running system setup...${RESET}"
			run_setup_master #^ Вызов функции мастера настройки системы
		;;
        "9"|"9. Exit"|"9."|"Exit"|"exit"|"quit")
			echo -e "Exiting script..."
			exit 0 #! Выход из программы по желанию пользователя
		;;
		*)
			echo -e "${YELLOW}WARNING!${RESET} You should choise next action from list above!"
			echo
		    echo -en "Your action: ${MAGENTA}"
			read -r next_action
			continue
		;;
		esac
	
		break
	done
}

#FUNC Функция запуска таймера обратного отсчета до создания лога нового дня
timer_create_next_log() {
    # Текущая дата
    current_time=$(date '+%F %H:%M:%S')
#    echo "current_time=${current_time}"

    # Перевод текущей даты в секунды
    current_time_in_sec="$(date "+%s" --date="$current_time")"
#    echo "current_time_in_sec=${current_time_in_sec}"

    # Перевод конца дня в секунды
    current_day=$(date '+%F')
    end_of_day_in_sec="$(date "+%s" --date="$current_day"" 23:59:59")"
#   echo "end_of_day_in_sec=${end_of_day_in_sec}"

    # Дельта (разница последних секунд в дне и прошедших секунд в дне) 
    delta_sec=$(( "${end_of_day_in_sec}" - "${current_time_in_sec}" ))
#    echo "delta_sec=${delta_sec}"

    for ((i=0;i<="${delta_sec}";i++)); do
        sleep 1
    done

    create_log #^ Вызов функции создания лога и структуры папок (РЕКУРСИВНО)

    # Знак "&" — запускает функцию/команду в фоне
    timer_create_next_log & #^ Вызов функции запуска таймера обратного отсчета до создания лога нового дня
}

#FUNC Функция создания лога и структуры папок
create_log() {
    # Получение текущей даты
    local current_date
    current_date=$(date '+%F')

    local current_year
    current_year=$(date '+%Y')

    local current_month
    current_month=$(date '+%m (%B)')

    # Проверка на существование структуры дирректории с логами
    local path_of_logs
    path_of_logs=~/script/logs

    if [[ ! -d "${path_of_logs}" ]]; then
        # echo 'Directory of logs not exist'
        mkdir -p ~/script/logs
    fi

    if [[ ! -d "${path_of_logs}/${current_year}" ]]; then
        # echo 'Directory of year not exist'
        mkdir "${path_of_logs}/${current_year}"
    fi

    local path_to_current_log_dir
    path_to_current_log_dir="${path_of_logs}/${current_year}/${current_month}"

    if [[ ! -d "${path_to_current_log_dir}" ]]; then
        # echo 'Directory of month not exist'
        mkdir "${path_to_current_log_dir}"
    fi

    local log_filename
    log_filename="log_""${current_date}"".txt"

    local full_path_to_log
    full_path_to_log="${path_to_current_log_dir}/${log_filename}"

    # Проверка на сущестование лога и его создание
    if [[ ! -f "${full_path_to_log}" ]]; then
        # echo "${log_filename} is not exist"
        cd "${path_to_current_log_dir}" || exit
        touch "${log_filename}"
    fi
}

#!#########################
#!    НАЧАЛО ПРОГРАММЫ    #
#!#########################

# Проверка системы (debian 11 && debian 10 only!)
oc_type=$(hostnamectl | grep -E 'Operating System: ' | (sed -r "s/  Operating System: //") || true)
# echo "oc_type=${oc_type}"
if [[ "${oc_type}" != 'Debian GNU/Linux 11 (bullseye)' ]] && [[ "${oc_type}" != 'Debian GNU/Linux 10 (buster)' ]]; then
    echo -e "This scipt should be run on ${GREEN}Debian 11${RESET} or ${GREEN}Debian 10${RESET} only!"
    echo -e "You current distribution: ${YELLOW}${oc_type}${RESET}"
    exit 1 #! Выход из программы аварийно. Неподдерживаемый дистрибутив
fi

# Переменная с текущим пользователем системы
check_user=$(whoami)

# Проверка пользователя
if [[ "${check_user}" != 'root' ]]; then
    echo -e "This scipt should be run by ${RED}root${RESET} user only! Please, relogin and start script again."
    exit 1 #! Выход из программы аварийно. Не достаточно прав текущего пользователя
fi

create_log #^ Вызов функции создания лога и структуры папок

# Знак "&" — запускает функцию/команду в фоне
timer_create_next_log & #^ Вызов функции запуска таймера обратного отсчета до создания лога нового дня

echo 'Hello. Welcome to script of system setup'
show_main_menu #^ Вызов функции вывода главного меню
