" ==============================================================================
" Vim syntax file
" Language:        C++ (Standard library including C++11/14/17/20)
" Original Author: Jon Haggblad <https://github.com/octol>
" Maintainer:      bfrg <bfrg@users.noreply.github.com>
" Website:         https://github.com/bfrg/vim-cpp-modern
" Last Change:     Jun 23, 2020
"
" This syntax file is based on:
" https://github.com/octol/vim-cpp-enhanced-highlight
" http://www.vim.org/scripts/script.php?script_id=4293
" ==============================================================================

" Standard library {{{1
syntax keyword cppSTLconstant
        \ MB_CUR_MAX MB_LEN_MAX WCHAR_MAX WCHAR_MIN WEOF __STDC_UTF_16__ __STDC_UTF_32__

syntax keyword cppSTLconstant
        \ badbit digits digits10 eofbit failbit goodbit has_denorm has_denorm_loss has_infinity has_quiet_NaN has_signaling_NaN is_bounded is_exact is_iec559 is_integer is_modulo is_signed is_specialized max_exponent max_exponent10 min_exponent min_exponent10 nothrow npos radix round_style tinyness_before traps

syntax keyword cppSTLVariable
        \ cerr cin clog cout wcerr wcin wclog wcout

syntax keyword cppSTLexception
        \ bad_alloc bad_exception bad_typeid bad_cast domain_error exception failure invalid_argument length_error logic_error out_of_range overflow_error range_error runtime_error underflow_error

syntax keyword cppSTLfunctional
        \ binary_function binary_negate bit_and bit_not bit_or divides equal_to greater greater_equal less less_equal logical_and logical_not logical_or minus modulus multiplies negate not_equal_to plus unary_function unary_negate

syntax keyword cppSTLios
        \ endl ends flush resetiosflags setbase setfill setiosflags setprecision setw ws

syntax keyword cppSTLios
        \ boolalpha dec defaultfloat fixed hex hexfloat internal left noboolalpha noshowbase noshowpoint noshowpos noskipws nounitbuf nouppercase oct right scientific showbase showpoint showpos skipws unitbuf uppercase

syntax keyword cppSTLtype
        \ fmtflags iostate openmode

" Some of these can be highlighted as both cppSTLios and cppSTLconstant
" syntax keyword cppSTLconstant
"         \ adjustfield app ate basefield binary floatfield in out trunc boolalpha dec fixed hex internal left oct right scientific showbase showpoint showpos skipws unitbuf uppercase

syntax keyword cppSTLiterator
        \ back_insert_iterator bidirectional_iterator const_iterator const_reverse_iterator forward_iterator front_insert_iterator input_iterator insert_iterator istream_iterator istreambuf_iterator iterator ostream_iterator ostreambuf_iterator output_iterator random_access_iterator raw_storage_iterator reverse_bidirectional_iterator reverse_iterator

syntax keyword cppSTLiterator_tag
        \ bidirectional_iterator_tag forward_iterator_tag input_iterator_tag output_iterator_tag random_access_iterator_tag

syntax keyword cppSTLnamespace
        \ experimental rel_ops std

syntax keyword cppSTLtype
        \ Init allocator auto_ptr basic_filebuf basic_fstream basic_ifstream basic_ios basic_iostream basic_istream basic_istringstream basic_ofstream basic_ostream basic_ostringstream basic_streambuf basic_string basic_stringbuf basic_stringstream binary_compose binder1st binder2nd bitset char_traits char_type const_mem_fun1_t const_mem_fun_ref1_t const_mem_fun_ref_t const_mem_fun_t const_pointer const_reference container_type deque difference_type div_t double_t event_callback filebuf first_type float_denorm_style float_round_style float_t fpos fstream gslice_array ifstream imaxdiv_t indirect_array int_type ios ios_base iostream istream istringstream istrstream iterator_category iterator_traits key_compare key_type ldiv_t list lldiv_t map mapped_type mask_array mbstate_t mem_fun1_t mem_fun_ref1_t mem_fun_ref_t mem_fun_t multimap multiset nothrow_t numeric_limits off_type ofstream ostream ostringstream ostrstream pair pointer pointer_to_binary_function pointer_to_unary_function pos_type priority_queue queue reference second_type seekdir sequence_buffer set sig_atomic_t size_type slice_array stack state_type stream streambuf streamoff streampos streamsize string stringbuf stringstream strstream strstreambuf temporary_buffer test_type time_t tm traits_type type_info u16string u32string unary_compose unary_negate valarray value_compare value_type vector wctrans_t wctype_t wfilebuf wfstream wifstream wint_t wios wiostream wistream wistringstream wofstream wostream wostringstream wstreambuf wstreampos wstring wstringbuf wstringstream

" locale
syntax keyword cppSTLtype
        \ codecvt codecvt_base codecvt_byname collate collate_byname ctype ctype_base ctype_byname locale messages messages_base messages_byname money_base money_get money_put moneypunct moneypunct_byname num_get num_put numpunct numpunct_byname time_base time_get time_get_byname time_put time_put_byname

" template functions that are called with template parameters, like
" std::use_facet<std::moneypunct<char, true>>(loc).curr_symbol()
syntax keyword cppSTLfunction use_facet has_facet

" std::get is a template function, so when called as std::get<N>(t), we want it
" to be highlighted as a function
syntax keyword cppSTLfunction get


" C++11 extensions {{{1
if !exists('cpp_no_cpp11')
    syntax keyword cppType char16_t char32_t
    syntax keyword cppSTLconstant nullptr

    " std containers
    syntax keyword cppSTLtype array

    " atomic
    syntax keyword cppSTLconstant ATOMIC_FLAG_INIT
    syntax keyword cppSTLenum memory_order
    syntax keyword cppSTLtype
            \ atomic atomic_bool atomic_char atomic_char16_t atomic_char32_t atomic_flag atomic_int atomic_int_fast16_t atomic_int_fast32_t atomic_int_fast64_t atomic_int_fast8_t atomic_int_least16_t atomic_int_least32_t atomic_int_least64_t atomic_int_least8_t atomic_intmax_t atomic_intptr_t atomic_llong atomic_long atomic_ptrdiff_t atomic_schar atomic_short atomic_size_t atomic_uchar atomic_uint atomic_uint_fast16_t atomic_uint_fast32_t atomic_uint_fast64_t atomic_uint_fast8_t atomic_uint_least16_t atomic_uint_least32_t atomic_uint_least64_t atomic_uint_least8_t atomic_uintmax_t atomic_uintptr_t atomic_ullong atomic_ulong atomic_ushort atomic_wchar_t

    " chrono
    syntax keyword cppSTLnamespace chrono
    syntax keyword cppSTLcast duration_cast time_point_cast
    syntax keyword cppSTLtype
            \ duration duration_values high_resolution_clock hours microseconds milliseconds minutes nanoseconds seconds steady_clock system_clock time_point treat_as_floating_point

    " condition_variable
    syntax keyword cppSTLtype condition_variable

    " cstddef
    syntax keyword cppSTLtype nullptr_t max_align_t

    " exception
    syntax keyword cppSTLtype exception_ptr nested_exception

    " functional
    syntax keyword cppSTLexception bad_function_call
    syntax keyword cppSTLfunctional function
    syntax keyword cppSTLfunction mem_fn
    syntax keyword cppSTLconstant _1 _2 _3 _4 _5 _6 _7 _8 _9
    syntax keyword cppSTLtype
            \ hash is_bind_expression is_placeholder reference_wrapper

    " iterator
    syntax keyword cppSTLiterator move_iterator

    " forward_list
    syntax keyword cppSTLtype forward_list

    " future
    syntax keyword cppSTLtype future packaged_task promise shared_future
    syntax keyword cppSTLenum future_status future_errc launch
    syntax keyword cppSTLexception future_error

    " initializer_list
    syntax keyword cppSTLtype initializer_list

    " ios
    syntax keyword cppSTLenum io_errc
    " syntax keyword cppSTLtype is_error_code_enum

    " limits
    syntax keyword cppSTLconstant max_digits10

    " locale
    syntax keyword cppSTLfunction isblank
    syntax keyword cppSTLtype
            \ codecvt_mode codecvt_utf16 codecvt_utf8 codecvt_utf8_utf16 wbuffer_convert wstring_convert

    " memory
    syntax keyword cppSTLconstant allocator_arg
    syntax keyword cppSTLexception bad_weak_ptr
    syntax keyword cppSTLfunction allocate_shared make_shared
    syntax keyword cppSTLfunction
            \ const_pointer_cast dynamic_pointer_cast static_pointer_cast

    syntax keyword cppSTLtype
            \ allocator_arg_t allocator_traits allocator_type default_delete enable_shared_from_this is_always_equal owner_less pointer_safety pointer_traits propagate_on_container_copy_assignment propagate_on_container_move_assignment propagate_on_container_swap rebind_alloc rebind_traits shared_ptr unique_ptr uses_allocator void_pointer const_void_pointer weak_ptr

    " mutex
    syntax keyword cppSTLenum cv_status
    syntax keyword cppSTLconstant defer_lock try_to_lock adopt_lock
    syntax keyword cppSTLtype
            \ adopt_lock_t condition_variable_any defer_lock_t lock_guard mutex once_flag recursive_mutex recursive_timed_mutex timed_mutex try_to_lock_t unique_lock

    " new
    syntax keyword cppSTLexception bad_array_new_length

    " numerics, cmath
    syntax keyword cppSTLconstant
            \ FLT_EVAL_METHOD FP_INFINITE FP_NAN FP_NORMAL FP_SUBNORMAL FP_ZERO HUGE_VALF HUGE_VALL INFINITY MATH_ERREXCEPT MATH_ERRNO NAN math_errhandling

    " random
    syntax keyword cppSTLfunction generate_canonical
    syntax keyword cppSTLtype
            \ bernoulli_distribution binomial_distribution cauchy_distribution chi_squared_distribution default_random_engine discard_block_engine discrete_distribution exponential_distribution extreme_value_distribution fisher_f_distribution gamma_distribution geometric_distribution independent_bits_engine knuth_b linear_congruential_engine lognormal_distribution mersenne_twister_engine minstd_rand minstd_rand0 mt19937 mt19937_64 negative_binomial_distribution normal_distribution piecewise_constant_distribution piecewise_linear_distribution poisson_distribution random_device ranlux24 ranlux24_base ranlux48 ranlux48_base seed_seq shuffle_order_engine student_t_distribution subtract_with_carry_engine uniform_int_distribution uniform_real_distribution weibull_distribution

    " ratio
    syntax keyword cppSTLtype
            \ atto centi deca deci exa femto giga hecto kilo mega micro milli nano peta pico ratio ratio_add ratio_divide ratio_equal ratio_greater ratio_greater_equal ratio_less ratio_less_equal ratio_multiply ratio_not_equal ratio_subtract tera yocto yotta zepto zetta

    " regex
    syntax keyword cppSTLiterator regex_iterator regex_token_iterator
    syntax keyword cppSTLexception regex_error
    syntax keyword cppSTLtype
            \ basic_regex match_results regex_traits sub_match syntax_option_type match_flag_type error_type

    " scoped_allocator
    syntax keyword cppSTLtype
            \ scoped_allocator_adaptor outer_allocator_type inner_allocator_type

    " system_error
    syntax keyword cppSTLenum errc
    syntax keyword cppSTLexception system_error
    syntax keyword cppSTLtype
            \ error_code error_condition error_category is_error_code_enum is_error_condition_enum

    " thread
    syntax keyword cppSTLnamespace this_thread
    syntax keyword cppSTLtype thread

    " tuple
    syntax keyword cppSTLtype tuple tuple_size tuple_element
    syntax keyword cppSTLfunction forward_as_tuple make_tuple tie tuple_cat
    " Note: ignore is also a function
    " syntax keyword cppSTLVariable ignore

    " typeindex
    syntax keyword cppSTLtype type_index

    " type_traits
    syntax keyword cppSTLtype
            \ add_const add_cv add_lvalue_reference add_pointer add_rvalue_reference add_volatile aligned_storage aligned_union alignment_of common_type conditional decay enable_if extent false_type has_virtual_destructor integral_constant is_abstract is_arithmetic is_array is_assignable is_base_of is_class is_compound is_const is_constructible is_convertible is_copy_assignable is_copy_constructible is_default_constructible is_destructible is_empty is_enum is_floating_point is_function is_fundamental is_integral is_literal_type is_lvalue_reference is_member_function_pointer is_member_object_pointer is_member_pointer is_move_assignable is_move_constructible is_nothrow_assignable is_nothrow_constructible is_nothrow_copy_assignable is_nothrow_copy_constructible is_nothrow_default_constructible is_nothrow_destructible is_nothrow_move_assignable is_nothrow_move_constructible is_object is_pod is_pointer is_polymorphic is_reference is_rvalue_reference is_same is_scalar is_signed is_standard_layout is_trivial is_trivially_assignable is_trivially_constructible is_trivially_copy_assignable is_trivially_copy_constructible is_trivially_copyable is_trivially_default_constructible is_trivially_destructible is_trivially_move_assignable is_trivially_move_constructible is_union is_unsigned is_void is_volatile make_signed make_unsigned rank remove_all_extents remove_const remove_cv remove_extent remove_pointer remove_reference remove_volatile result_of true_type underlying_type

    " unordered_map, unordered_set, unordered_multimap, unordered_multiset
    syntax keyword cppSTLiterator const_local_iterator local_iterator
    syntax keyword cppSTLtype
            \ hasher key_equal unordered_map unordered_multimap unordered_multiset unordered_set

    " utility
    syntax keyword cppSTLtype piecewise_construct_t
    syntax keyword cppSTLconstant piecewise_construct
    syntax keyword cppSTLfunction declval forward move move_if_noexcept
endif


" C++14 extensions {{{1
if !exists('cpp_no_cpp14')
    " chrono
    syntax keyword cppSTLnamespace literals chrono_literals

    " memory
    syntax keyword cppSTLfunction make_unique

    " utility
    syntax keyword cppSTLtype
            \ index_sequence index_sequence_for integer_sequence make_index_sequence make_integer_sequence

    " shared_mutex
    syntax keyword cppSTLtype shared_lock shared_timed_mutex

    " string
    syntax keyword cppSTLnamespace string_literals

    " tuple
    syntax keyword cppSTLtype tuple_element_t

    " type_traits
    syntax keyword cppSTLtype
            \ add_const_t add_cv_t add_lvalue_reference_t add_pointer_t add_rvalue_reference_t add_volatile_t aligned_storage_t aligned_union_t common_type_t conditional_t decay_t enable_if_t is_null_pointer make_signed_t make_unsigned_t remove_all_extents_t remove_const_t remove_cv_t remove_extent_t remove_pointer_t remove_reference_t remove_volatile_t result_of_t underlying_type_t
endif


" C++17 extensions {{{1
if !exists('cpp_no_cpp17')
    " any
    syntax keyword cppSTLtype any
    syntax keyword cppSTLexception bad_any_cast
    syntax keyword cppSTLcast any_cast

    " atomic
    syntax keyword cppSTLconstant is_always_lock_free

    " chrono
    syntax keyword cppSTLbool treat_as_floating_point_v

    " execution
    syntax keyword cppSTLnamespace execution
    syntax keyword cppSTLconstant seq par par_unseq
    syntax keyword cppSTLbool is_execution_policy_v
    syntax keyword cppSTLtype
            \ is_execution_policy parallel_policy parallel_unsequenced_policy sequenced_policy

    " filesystem
    syntax keyword cppSTLnamespace filesystem
    syntax keyword cppSTLexception filesystem_error

    syntax keyword cppSTLtype
            \ directory_entry directory_iterator file_status file_time_type path recursive_directory_iterator space_info

    syntax keyword cppSTLenum
            \ copy_options directory_options file_type perm_options perms

    " Note: There is std::filesystem::path::format and std::format() in <format>
    syntax match cppSTLenum "\<format\>(\@!"

    syntax keyword cppSTLconstant
            \ copy_symlinks auto_format create_hard_links create_symlinks directories_only follow_directory_symlink generic_format group_all group_exec group_read group_write native_format others_all others_exec others_read others_write overwrite_existing owner_all owner_exec owner_read owner_write preferred_separator recursive set_gid set_uid skip_existing skip_permission_denied skip_symlinks sticky_bit update_existing

    " Note: these keywords are very likely to coincide with user-defined variables
    " syntax keyword cppSTLconstant
    "         \ all mask unknown replace add remove nofollow none not_found regular directory symlink block character fifo socket unknown

    " Note: these are also functions
    " syntax keyword cppSTLconstant capacity free available

    " functional
    syntax keyword cppSTLbool is_bind_expression_v is_placeholder_v
    syntax keyword cppSTLtype
            \ default_order default_order_t default_searcher boyer_moore_searcher boyer_moore_horspool_searcher

    " memory
    syntax keyword cppSTLfunction reinterpret_pointer_cast
    syntax keyword cppSTLconstant uses_allocator_v

    " memory_resource
    syntax keyword cppSTLtype
            \ memory_resource monotonic_buffer_resource polymorphic_allocator pool_options synchronized_pool_resource unsynchronized_pool_resource

    " mutex
    syntax keyword cppSTLtype scoped_lock

    " new
    syntax keyword cppSTLconstant
            \ hardware_destructive_interference_size hardware_constructive_interference_size

    " optional
    syntax keyword cppSTLtype optional nullopt_t
    syntax keyword cppSTLexception bad_optional_access
    syntax keyword cppSTLconstant nullopt
    syntax keyword cppSTLfunction make_optional

    " shared_mutex
    syntax keyword cppSTLtype shared_mutex

    " string_view
    syntax keyword cppSTLtype
            \ basic_string_view string_view u16string_view u32string_view wstring_view

    " system_error
    syntax keyword cppSTLbool is_error_code_enum_v is_error_condition_enum_v

    " tuple
    syntax keyword cppSTLconstant tuple_size_v
    syntax keyword cppSTLfunction make_from_tuple

    " type_traits
    syntax keyword cppSTLconstant alignment_of_v rank_v extent_v
    syntax keyword cppSTLbool
            \ conjunction_v disjunction_v has_unique_object_representations_v has_virtual_destructor_v is_abstract_v is_aggregate_v is_arithmetic_v is_array_v is_assignable_v is_base_of_v is_callable_v is_class_v is_compound_v is_const_v is_constructible_v is_convertible_v is_copy_assignable_v is_copy_constructible_v is_default_constructible_v is_destructible_v is_empty_v is_enum_v is_floating_point_v is_function_v is_fundamental_v is_integral_v is_invocable_r_v is_invocable_v is_literal_type_v is_lvalue_reference_v is_member_function_pointer_v is_member_object_pointer_v is_member_pointer_v is_move_assignable_v is_move_constructible_v is_nothrow_assignable_v is_nothrow_constructible_v is_nothrow_copy_assignable_v is_nothrow_copy_constructible_v is_nothrow_default_constructible_v is_nothrow_destructible_v is_nothrow_invocable_r_v is_nothrow_invocable_v is_nothrow_move_assignable_v is_nothrow_move_constructible_v is_nothrow_swappable_v is_nothrow_swappable_with_v is_nowthrow_callable_v is_null_pointer_v is_object_v is_pod_v is_pointer_v is_polymorphic_v is_reference_v is_rvalue_reference_v is_same_v is_scalar_v is_signed_v is_standard_layout_v is_swappable_v is_swappable_with_v is_trivial_v is_trivially_assignable_v is_trivially_constructible_v is_trivially_copy_assignable_v is_trivially_copy_constructible_v is_trivially_copyable_v is_trivially_default_constructible_v is_trivially_destructible_v is_trivially_move_assignable_v is_trivially_move_constructible_v is_union_v is_unsigned_v is_void_v is_volatile_v negation_v

    syntax keyword cppSTLtype
            \ bool_constant conjunction disjunction has_unique_object_representations invoke_result invoke_result_t is_aggregate is_callable is_invocable is_invocable_r is_nothrow_invocable is_nothrow_invocable_r is_nothrow_swappable is_nothrow_swappable_with is_nowthrow_callable is_swappable is_swappable_with negation void_t

    " unordered_map, unordered_set, unordered_multimap, unordered_multiset
    syntax keyword cppSTLtype node_type insert_return_type

    " utility
    syntax keyword cppSTLtype
            \ in_place_tag in_place_t in_place_type_t in_place_index_t

    " variant
    syntax keyword cppSTLconstant variant_npos variant_size_v
    syntax keyword cppSTLexception bad_variant_access
    syntax keyword cppSTLtype
            \ monostate variant variant_size variant_alternative variant_alternative_t
endif


" C++20 extensions {{{1
if !exists('cpp_no_cpp20')
    syntax keyword cppType char8_t
    syntax keyword cppOperator co_await
    syntax keyword cppStatement consteval constinit concept requires co_yield co_return

    " atomic
    syntax keyword cppSTLtype atomic_ref

    " bit
    syntax keyword cppSTLtype endian

    " compare
    syntax keyword cppSTLtype
            \ weak_ordering strong_ordering partial_ordering weak_equality strong_equality common_comparison_category common_comparison_category_t

    " concepts
    syntax keyword cppSTLconcept
            \ assignable_from boolean common_reference_with common_with constructible_from convertible_to copy_constructible copyable default_constructible derived_from destructible equality_comparable equality_comparable_with equivalence_relation floating_point integral invocable movable move_constructible predicate regular regular_invocable relation same_as semiregular signed_integral strict_weak_order swappable swappable_with totally_ordered totally_ordered_with unsigned_integral default_initializable

    " concepts - named requirements
    " These are concepts that haven't made it into the C++ Standard yet
    " https://en.cppreference.com/w/cpp/named_req
    " http://en.cppreference.com/w/cpp/language/constraints
    if get(g:, 'cpp_named_requirements_highlight', 0)
        syntax keyword cppSTLNamedReq
                \ Allocator AllocatorAwareContainer AssociativeContainer BasicLockable BidirectionalIterator BinaryPredicate BinaryTypeTrait BitmaskType Callable CharTraits Clock Compare ConstExprIterator Container ContiguousContainer ContiguousIterator CopyAssignable CopyInsertable CopyInsertable DefaultInsertable EmplaceConstructible Erasable FormattedInputFunction FormattedOutputFunction ForwardIterator FunctionObject Hash InputIterator Iterator LessThanComparable LiteralType Lockable MoveAssignable MoveInsertable Mutex NullablePointer NumericType OutputIterator PODType RandomAccessIterator RandomNumberDistribution RandomNumberEngine RandomNumberEngineAdaptor RegexTraits ReversibleContainer SeedSequence SequenceContainer SharedMutex SharedTimedMutex StandardLayoutType TimedLockable TimedMutex TransformationTrait TrivialClock TrivialType TriviallyCopyable UnaryTypeTrait UnformattedInputFunction UnformattedOutputFunction UniformRandomBitGenerator UnorderedAssociativeContainer ValueSwappable
        hi def link cppSTLNamedReq Typedef
    endif

    " contract
    syntax keyword cppSTLtype contract_violation

    " coroutines
    syntax keyword cppSTLtype
            \ coroutine_traits coroutine_handle noop_coroutine_handle noop_coroutine_promise suspend_never suspend_always

    " memory
    syntax keyword cppSTLfunction
            \ make_unique_default_init make_shared_default_init allocate_shared_default_init uses_allocator_construction_args make_obj_using_allocator

    " type_traits
    syntax keyword cppSTLtype
            \ remove_cvref remove_cvref_t is_bounded_array is_layout_compatible is_unbounded_array is_nothrow_convertible has_strong_structural_equality is_pointer_interconvertible_base_of unwrap_reference unwrap_reference_t unwrap_ref_decay unwrap_ref_decay_t basic_common_reference common_reference common_reference_t

    syntax keyword cppSTLbool
            \ is_bounded_array_v is_layout_compatible_v is_unbounded_array_v is_nothrow_convertible_v has_strong_structural_equality_v is_pointer_interconvertible_base_of_v

    syntax keyword cppSTLfunction is_corresponding_member

    " ranges
    syntax keyword cppSTLnamespace ranges views

    syntax keyword cppSTLconcept
            \ range sized_range view input_range output_range forward_range bidirectional_range random_access_range contiguous_range common_range viewable_range

    syntax keyword cppSTLtype
            \ iterator_t sentinel_t dangling safe_iterator_t safe_subrange_t ref_view filter_view transform_view iota_view join_view empty_view single_view split_view common_view reverse_view view_interface

    " span
    syntax keyword cppSTLtype span
    syntax keyword cppSTLconstant dynamic_extent
    syntax keyword cppSTLfunction subspan

    " syncstream
    syntax keyword cppSTLtype
            \ basic_syncbuf basic_osyncstream syncbuf wsyncbuf osyncstream wosyncstream
endif

" Boost {{{1
if !exists('cpp_no_boost')
    syntax keyword cppSTLnamespace boost
    syntax keyword cppSTLcast lexical_cast
endif
" }}}


" Default highlighting
hi def link cppSTLbool         Boolean
hi def link cppStatement       Statement
hi def link cppSTLfunction     Function
hi def link cppSTLfunctional   Typedef
hi def link cppSTLconstant     Constant
hi def link cppSTLnamespace    Constant
hi def link cppSTLtype         Typedef
hi def link cppSTLexception    Exception
hi def link cppSTLiterator     Typedef
hi def link cppSTLiterator_tag Typedef
hi def link cppSTLenum         Typedef
hi def link cppSTLios          Function
hi def link cppSTLcast         Statement
hi def link cppSTLconcept      Typedef
hi def link cppSTLVariable     Identifier

" The keywords {inline, virtual, explicit, export, override, final} are
" standard C++ keywords and NOT types!
hi link cppModifier Statement


" Highlight all standard C++ keywords as Statement
if get(g:, 'cpp_simple_highlight', 0)
    hi link cppStructure    Statement
    hi link cppExceptions   Statement
    hi link cppStorageClass Statement
    hi link cppSTLexception Typedef
endif

"___Unison keywords___"
"_____________________"
syn keyword unisonClass CBIT CLOCK MATRIX CPMU DSP RF DIGITAL SYS SEQ GPIB TMU VI MATH ADC CODEC DAC EVM TIME CONV VP ERR IO
                      \ ProfileTT DIEXT DLOGMOD PARSEX GU THORSOLT THORRF SERVOTYPE SearchMod SEARCHM VSA Math VSAPlotter PLOT

syn keyword unisonDataTypes ArrayOfBasicVar ArrayOfBoolM ArrayOfBoolM1D ArrayOfBoolM2D ArrayOfBoolM3D ArrayOfBoolS ArrayOfBoolS1D ArrayOfBoolS2D ArrayOfBoolS3D ArrayOfFloatM ArrayOfFloatM1D ArrayOfFloatM2D ArrayOfFloatM3D ArrayOfFloatML ArrayOfFloatS 
                          \ ArrayOfFloatS1D ArrayOfFloatS2D ArrayOfFloatS3D ArrayOfFloatSL ArrayOfIntM ArrayOfIntM1D ArrayOfIntM2D ArrayOfIntM3D ArrayOfIntML ArrayOfIntS ArrayOfIntS1D ArrayOfIntS2D ArrayOfIntS3D ArrayOfIntSL ArrayOfObjectM ArrayOfObjectM1D
                          \ ArrayOfObjectM2D ArrayOfObjectM3D ArrayOfObjectML ArrayOfObjectS ArrayOfObjectS1D ArrayOfObjectS2D ArrayOfObjectS3D ArrayOfObjectSL ArrayOfPinM ArrayOfPinML ArrayOfStringM ArrayOfStringM1D ArrayOfStringM2D ArrayOfStringM3D
                          \ ArrayOfStringML ArrayOfStringS ArrayOfStringS1D ArrayOfStringS2D ArrayOfStringS3D ArrayOfStringSL ArrayOfUnsignedM ArrayOfUnsignedM1D ArrayOfUnsignedM2D ArrayOfUnsignedM3D ArrayOfUnsignedML ArrayOfUnsignedS ArrayOfUnsignedS1D
                          \ ArrayOfUnsignedS2D ArrayOfUnsignedS3D ArrayOfUnsignedSL BoolM BoolM1D BoolM2D BoolM3D BoolS BoolS1D BoolS2D BoolS3D FloatM FloatM1D FloatM2D FloatM3D FloatML FloatS FloatS1D FloatS2D FloatS3D FloatSL IntM IntM1D IntM2D IntM3D
                          \ IntML IntS IntS1D IntS2D IntS3D IntSL MagicVar ObjectM ObjectM1D ObjectM2D ObjectM3D ObjectML ObjectS ObjectS1D ObjectS2D ObjectS3D ObjectSL PinM PinML StringM StringM1D StringM2D StringM3D StringML StringS StringS1D StringS2D
                          \ StringS3D StringSL UnsignedM UnsignedM1D UnsignedM2D UnsignedM3D UnsignedML UnsignedS UnsignedS1D UnsignedS2D UnsignedS3D UnsignedSL

syn keyword unisonTypeDefs RFAutoCalConnectModeM RFAutoCalConnectModeM1D RFAutoCalConnectModeS RFAutoCalStatusS RFAutoCalTypeS RFAverageModeM RFAverageModeM1D RFAverageModeS RFCalSetupModeS RFDataModeM RFDataModeM1D RFDataModeS RFDataSliceM RFDataSliceM1D
                         \ RFDataSliceS RFExternalSourceS RFFilterTypeM RFFilterTypeM1D RFFilterTypeS RFFrequencyDomainModeM RFFrequencyDomainModeM1D RFFrequencyDomainModeS RFFrequencyTypeM RFFrequencyTypeM1D RFFrequencyTypeS RFIFOutputM RFIFOutputM1D
                         \ RFIFOutputS RFInitializeS RFInterpolationTypeM RFInterpolationTypeM1D RFInterpolationTypeS RFLogAmpM RFLogAmpM1D RFLogAmpS RFMeasureModeM RFMeasureModeM1D RFMeasureModeS RFModulationModeM RFModulationModeM1D RFModulationModeS
                         \ RFNoiseCalFactorTypeS RFNoiseResultTypeM RFNoiseResultTypeM1D RFNoiseResultTypeS RFNoiseSourceM RFNoiseSourceM1D RFNoiseSourceS RFPathModeM RFPathModeM1D RFPathModeS RFPathS RFPerformanceS RFPhaseNoiseOptimizationModeM
                         \ RFPhaseNoiseOptimizationModeM1D RFPhaseNoiseOptimizationModeS RFPrecisionM RFPrecisionM1D RFPrecisionS RFResourceModeM RFResourceModeM1D RFResourceModeS RFSamplingModeM RFSamplingModeM1D RFSamplingModeS RFSequenceModeM
                         \ RFSequenceModeM1D RFSequenceModeS RFSetupModeM RFSetupModeM1D RFSetupModeS RFSetupModeS1D RFSetupModeS2D RFSetupTypeS RFSourceTypeS RFSyncModeS RFToneM RFToneM1D RFToneS RFVectorResultTypeM RFVectorResultTypeM1D RFVectorResultTypeS
                         \ Sites SiteIter RunTime SITE
                         \ PinMLIter
                         \ TMResultM TMResultM1D TMResultS TMResultS1D WordOrientationS
                         \ ThorRFPort MEASUREMENTTYPE PORTTYPE

syn keyword unisonEnums RF_AUTOCAL_DISCONNECTED RF_AUTOCAL_OPEN RF_AUTOCAL_SHORT RF_AUTOCAL_50OHM RF_AUTOCAL_75OHM RF_AUTOCAL_THRU RF_AUTOCAL_THRU_10DB RF_AUTOCAL_POWER_SENSOR RF_AUTOCAL_NOISE_SOURCE RF_AUTOCAL_EXTERNAL_SOURCE RF_AUTOCAL_EXTERNAL_SOURCE_TO_POWER_SENSOR
                      \ RF_AUTOCAL_OK RF_AUTOCAL_COULD_NOT_OPEN RF_AUTOCAL_COULD_NOT_CLOSE RF_AUTOCAL_ERROR RF_AUTOCAL_NUM RF_AUTOCAL_16 RF_AUTOCAL_32 RF_AUTOCAL_NONE RF_AVERAGE_UTP RF_AVERAGE_POWER RF_CAL_SETUP_MODE_SOURCE RF_CAL_SETUP_MODE_MEASURE RF_CAL_SETUP_MODE_NOISE
                      \ RF_CAL_SETUP_MODE_VECTOR RF_CAL_SETUP_MODE_SWEPT RF_CONSTR_SOURCE_LEVEL RF_CONSTR_SOURCE_FREQUENCY RF_CONSTR_MEASURE_LEVEL RF_CONSTR_MEASURE_RESBW RF_CONSTR_IF_GAIN RF_CONSTR_LO_FREQUENCY RF_CONSTR_SAMPLES RF_CONSTR_SAMPLE_RATE RF_CONSTR_UTP_AVERAGES
                      \ RF_CONSTR_TIMEOUT RFDIG_CONSTR_CARRIER RFDIG_CONSTR_LO_FREQUENCY RFDIG_CONSTR_LPF_FREQUENCY RF_CONSTR_NUM RF_DATA_CALIBRATED RF_DATA_RAW RF_ALL_DATA RF_NOISE_COLD RF_NOISE_HOT RF_2PORT_FORWARD RF_2PORT_REVERSE RF_EXTERNAL_SOURCE_ON
                      \ RF_EXTERNAL_SOURCE_OFF RF_FILTER_BAND_PASS RF_FILTER_LOW_PASS RF_FILTER_HIGH_PASS RF_FILTER_NONE RF_FFT RF_POWER_AVERAGE RF_POWER_PEAK RF_POWER_FFT RF_LOG_DBC RF_LOG_DBM RF_IF_FREQUENCY RF_LO_FREQUENCY RF_IF_TO_DIGITIZER RF_IF_EXTERNAL RF_IF_TO_ANALOG_MONITOR
                      \ RF_INITIALIZE_FULL RF_INITIALIZE_PARTIAL RF_HW_INTERPOLATION RF_SW_INTERPOLATION RF_LOG_AMP_DIGITIZER RF_LOG_AMP_ABUS1 RF_LOG_AMP_ABUS3 RF_SCALAR RF_INCIDENT  RF_REFLECTED RF_LOOPBACK RF_MODULATION_I RF_MODULATION_Q RF_MODULATION_I_Q
                      \ RF_CALFACTOR_NOISE_ENR RF_CALFACTOR_NOISE_PCOLD RF_CALFACTOR_NOISE_GAIN_BANDWIDTH RF_CALFACTOR_NOISE_NFSYS RF_CALFACTOR_NOISE_PORT_DSA RF_CALFACTOR_TYPE_NUM RF_NOISE_FIGURE RF_NOISE_FACTOR RF_NOISE_GAIN RF_NOISE_ON RF_NOISE_OFF RF_THRU_THRU
                      \ RF_GAIN_THRU RF_THRU_GAIN RF_GAIN_GAIN RF_PATH_NUM RF_PATH_NORMAL RF_PATH_LOCKED RF_PERFORMANCE_HIGH_LINEARITY RF_PERFORMANCE_HIGH_SNR RF_PERFORMANCE_ENHANCED_SNR RF_PHASE_NOISE_BEST_WIDE_OFFSET RF_PHASE_NOISE_BEST_CLOSE_IN
                      \ RF_PHASE_NOISE_OPTIMIZATION_TYPE_NUM RF_LOW_PRECISION RF_HIGH_PRECISION RF_DEFAULT_MODE RF_GEN_PER_PORT RF_GEN_PER_PORT RF_GEN_SPLIT RF_GEN_RESERVED RF_GEN_SPLIT_RESERVED RF_GEN_SHARED RF_DIG_SAME_BOARD RF_DIG_DISTINCT_BOARD
                      \ RF_SAMPLING_AUTO RF_MINIMUM_INTERPOLATION RF_ZERO_ORDER_HOLD RF_SEQUENCE_USER RF_SEQUENCE_INTERNAL RF_AWG_RESERVED RF_DIG_RESERVED  RF_SOURCE_CW RF_SOURCE_MOD RF_SOURCE_2TONE RF_SOURCE_2TONE_MOD RF_SOURCE_2TONE_CW_MOD RF_SOURCE_NOISE
                      \ RF_MEASURE RF_MEASURE_LOG_AMP RF_MEASURE_VECTOR RF_MEASURE_SWEPT RF_MEASURE_EXTENDED RF_SETUP_SRC RF_SETUP_MSR RF_SOURCE_INTERNAL RF_SOURCE_EXTERNAL RF_S11 RF_SYNC_MODE_SYNCHRONOUS RF_SYNC_MODE_ASYNCHRONOUS RF_S21 RF_S12 RF_S22 RF_TONE_1
                      \ RF_TONE_2 RF_TONE_BOTH RF_MA RF_RI RF_DB RF_REAL RF_IMAG RF_MAG RF_ANG RF_MA_PAIR RF_RI_PAIR RF_VECTOR_CARTESIAN RF_VECTOR_LOG_POLAR  RF_VECTOR_POLAR RF_VECTOR_VSWR RF_VECTOR_RETURN_LOSS 
                      \ SV_CONFIG_NONE SV_SCALAR_S SV_SCALAR_M SV_ARRAY_S1D SV_ARRAY_M1D SV_ARRAY_S2D SV_ARRAY_M2D SV_ARRAY_S3D SV_ARRAY_M3D SV_LIST_S SV_LIST_M SV_MAX_CONFIG SV_CONTENT_KEEP SV_CONTENT_LOSE SV_TYPE_NONE SV_INT SV_UINT SV_FLOAT SV_BOOL SV_STRING SV_PIN
                      \ SV_OBJECT SV_ENUM SV_ARRAY_OF SV_MAX_TYPE SV_RANGE_AUTO SV_RANGE_1a SV_RANGE_1f SV_RANGE_1p SV_RANGE_1n SV_RANGE_1u SV_RANGE_1m SV_RANGE_1 SV_RANGE_1K SV_RANGE_1M SV_RANGE_1G SV_RANGE_1T SV_RANGE_1P SV_RANGE_1E
                      \ VI_ACCURACY_HIGH VI_ACCURACY_LOW VI_ALARM_NONE VI_ALARM_CLAMP_MAX VI_ALARM_CLAMP_MIN VI_ALARM_CLAMP VI_ALARM_DUTY_CYCLE VI_ALARM_GATE VI_ALARM_UNDERCURRENT VI_ALARM_TEMP VI_ALARM_MEASURE_OVERFLOW VI_ALARM_MEASURE_UNDERFLOW VI_ALARM_TRANSIENT_HIGHLIMIT
                      \ VI_ALARM_TRANSIENT_LOWLIMIT VI_ALARM_KELVIN_LOW VI_ALARM_KELVIN_HIGH VI_ALARM_TRIGGER VI_ALARM_ALLBITS VI_COMP_MIN_RISE_TIME VI_COMP_MIN_SETTLING_TIME VI_COMP_MIN_OVERSHOOT VI_COMP_MIN_RESISTANCE VI_CONFIG_PULSED VI_CONFIG_CONTINUOUS VI_MODE_LOCAL
                      \ VI_MODE_REMOTE VI_MODE_REMOTE_HIZ VI_MODE_VM VI_MODE_THROUGH VI_MODE_DISCHARGE VI_CONNECT_MS_HS VI_CONNECT_MS_LS VI_CONNECT_MS_BOTH VI_TO_DUT VI_TO_ABUS VI_LOOPBACK VI_DISCONNECTED VI_CONSTR_VFORCE VI_CONSTR_IFORCE VI_CONSTR_VCLAMP_MAX
                      \ VI_CONSTR_VCLAMP_MIN VI_CONSTR_ICLAMP_MAX VI_CONSTR_ICLAMP_MIN VI_CONSTR_VMEASURE VI_CONSTR_IMEASURE VI_CONSTR_MEASURE_SAMPLES VI_CONSTR_MEASURE_DELAY VI_CONSTR_MEASURE_TRIGGER_DELAY VI_CONSTR_GATE_TIME VI_CONSTR_RIPPLE_GAIN VI_CONSTR_CLOAD
                      \ VI_CONSTR_RLOAD VI_CONSTR_COMP_T1 VI_CONSTR_COMP_T2 VI_CONSTR_COMP_GAIN VI_CONSTR_CONFIG_V VI_CONSTR_CONFIG_I VI_CONSTR_WAVEFORM_SAMPLE_RATE VI_CONSTR_WAVEFORM_LOOP_COUNT VI_CONSTR_WAVEFORM_SAMPLES VI_CONSTR_CHARGE_WAIT_THRESHOLD
                      \ VI_CONSTR_BANDWIDTH_FREQUENCY VI_CONSTR_KELVIN_ALARM_THRESHOLD VI_CONSTR_TRANSIENT_VOLTAGE VI_CONSTR_TRANSIENT_CURRENT VI_CONSTR_NUM VI_FILTER_BYPASS VI_FILTER_LOW_PASS VI_GATE_AUTO_OFF VI_GATE_NO_AUTO_OFF VI_GATE_TRIGGERED VI_GATE_ON
                      \ VI_GATE_OFF_LOZ VI_GATE_OFF_HIZ VI_GUARD_FLOATING VI_GUARD_GROUNDED VI_GUARD_DRIVEN VI_MEASURE_FILTER_V VI_MEASURE_FILTER_I VI_MEASURE_FILTER_V_I VI_MEASURE_FILTER_OFF VI_MEASURE_AVERAGE VI_MEASURE_SAMPLES VI_RAILS_POSITIVE VI_RAILS_NEGATIVE
                      \ VI_RAILS_BALANCED VI_RIPPLE_TO_DUT VI_RIPPLE_TO_DUT_DIFF VI_RIPPLE_TO_ABUS VI_RIPPLE_TO_ABUS_DIFF VI_RIPPLE_SOURCE VI_RIPPLE_DISCONNECTED VI_RIPPLE_NONINVERTED VI_RIPPLE_INVERTED VI_SOURCE_VIS VI_SOURCE_PAS VI_SOURCE_LOAD_CONTINUITY
                      \ VI_SOURCE_LOAD_LEAKAGE VI_SWITCH_AUTO VI_SWITCH_HOT VI_TRIGGER_START VI_TRIGGER_STEP VI_TRIGGER_GATE VI_WAVEFORM_ARBITRARY VI_WAVEFORM_SINE VI_WAVEFORM_NULL_SINE VI_WAVEFORM_RAMP VI_WAVEFORM_TRIANGLE
                      \ DIGITAL_BIST_NONE DIGITAL_BIST_DONE DIGITAL_BIST_TIMEOUT DIGITAL_CAPTURE_PARALLEL DIGITAL_CAPTURE_SERIAL DIGITAL_CMP_MODE_PATTERN DIGITAL_CMP_MODE_MASK DIGITAL_CMP_MODE_ACTIVE DIGITAL_CMP_MODE_FLOAT DIGITAL_CMP_VOL DIGITAL_CMP_VOH DIGITAL_CMP_STATE_LOW
                      \ DIGITAL_CMP_STATE_HIGH DIGITAL_CMP_STATE_FLOAT DIGITAL_CMP_STATE_REVERSE DIGITAL_CMP_STATE_UNKNOWN DIGITAL_DCL_TO_DUT DIGITAL_ABUS_TO_DUT DIGITAL_ALL_PATHS DIGITAL_LIN_DCL_TO_DUT DIGITAL_CAN_DCL_TO_DUT DIGITAL_CONSTR_VIL DIGITAL_CONSTR_VIH
                      \ DIGITAL_CONSTR_VOH DIGITAL_CONSTR_VOL DIGITAL_CONSTR_IOH DIGITAL_CONSTR_IOHR DIGITAL_CONSTR_IOL DIGITAL_CONSTR_IOLR DIGITAL_CONSTR_VREF DIGITAL_CONSTR_VCH DIGITAL_CONSTR_VCL DIGITAL_CONSTR_RLV DIGITAL_CONSTR_REG_SEND_WORD_SIZE DIGITAL_CONSTR_DSP_SEND_WORD_SIZE
                      \ DIGITAL_CONSTR_CAPTURE_WORD_SIZE DIGITAL_CONSTR_CLV DIGITAL_CONSTR_VOH_HYSTERESIS DIGITAL_CONSTR_VOL_HYSTERESIS DIGITAL_CYCLE_COUNTER DIGITAL_INHIBIT_CYCLE_COUNTER DIGITAL_FAIL_COUNTER DIGITAL_COUNTER_CA DIGITAL_COUNTER_CB DIGITAL_COUNTER_CC DIGITAL_COUNTER_CD
                      \ DIGITAL_DIFF_NONE DIGITAL_DIFF_INPUT DIGITAL_DIFF_OUTPUT DIGITAL_DIFF_BIDIRECT DIGITAL_DRV_MODE_PATTERN DIGITAL_DRV_MODE_LOW DIGITAL_DRV_MODE_HIGH DIGITAL_DRV_MODE_OFF DIGITAL_DRV_MODE_ON DIGITAL_DRV_STATE_OFF DIGITAL_DRV_STATE_LOW DIGITAL_DRV_STATE_HIGH
                      \ DIGITAL_DRV_T1 DIGITAL_DRV_T2 DIGITAL_DRV_T3 DIGITAL_DRV_T4 DIGITAL_CMP_T1 DIGITAL_CMP_T2 DIGITAL_CMP_T3 DIGITAL_CMP_T4 DIGITAL_MEM_PASS DIGITAL_MEM_FAIL DIGITAL_MEM_REPAIRABLE DIGITAL_MEM_NON_REPAIRABLE DIGITAL_MEM_DEAD DIGITAL_MEM_TIMEOUT
                      \ DIGITAL_PACK_BY_PINS DIGITAL_PACK_BY_CYCLE DIGITAL_PATTERN_IDLE DIGITAL_PATTERN_RUNNING DIGITAL_PATTERN_KAP DIGITAL_SEARCH_BINARY DIGITAL_SEARCH_LINEAR DIGITAL_SEARCH_BINARY_LINEAR DIGITAL_SEARCH_LINEAR_LINEAR DIGITAL_SEARCH_LINEAR_PASS_TO_FAIL
                      \ DIGITAL_SEARCH_LINEAR_FAIL_TO_PASS DIGITAL_SEARCH_SUCCESSFUL DIGITAL_SEARCH_NO_TRANSITION_FAIL DIGITAL_SEARCH_NO_TRANSITION_PASS DIGITAL_SEARCH_NO_TRANSITION_FAIL_TO_PASS DIGITAL_SEARCH_NO_TRANSITION_PASS_TO_FAIL DIGITAL_SEND_SWITCH_START
                      \ DIGITAL_SEND_SWITCH_NEXT DIGITAL_SEND_SWITCH_LAST DIGITAL_SEND_PARALLEL DIGITAL_SEND_SERIAL DIGITAL_TRIGGER_EDGE DIGITAL_TRIGGER_PULSE DIGITAL_TRIGGER_LATCH
                      \ COLLECT_RESET COLLECT_ACCUMULATE CONNECT_OFF CONNECT_ON EDGE_RISING EDGE_FALLING MEASURE_PARALLEL MEASURE_SERIAL OPTIMIZE_FOR_SPEED OPTIMIZE_FOR_ACCURACY
                      \ TM_PASS TM_FAIL TM_NOTEST TM_PARAM_FAIL TM_REPAIRABLE TM_TIMEOUT WORD_MSB_FIRST WORD_LSB_FIRST
                      \ PORTTYPE HPRF RX TRX SCALAR PIN H2 H3
                      \ ActiveSites EnabledSites LoadedSites SelectedSites SuspendedSites
